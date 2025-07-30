{{/*
Expand the name of the chart.
*/}}
{{- define "cluster-wizard.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "cluster-wizard.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "cluster-wizard.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "cluster-wizard.labels" -}}
helm.sh/chart: {{ include "cluster-wizard.chart" . }}
{{ include "cluster-wizard.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "cluster-wizard.selectorLabels" -}}
app.kubernetes.io/name: {{ include "cluster-wizard.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service to use
*/}}
{{- define "cluster-wizard.service" -}}
cluster-wizard-svc
{{- end }}

{{/*
Create the name of the secret to use
*/}}
{{- define "cluster-wizard.secret" -}}
{{ .Release.Name }}-secret
{{- end }}

{{/*
Create the name of the app to use for postgres
*/}}
{{- define "cluster-wizard.DB" -}}
{{ .Release.Name }}-postgres
{{- end }}

{{/*
Create the name of the pvc to use for postgres
*/}}
{{- define "cluster-wizard.DB.volumeClaim" -}}
{{ .Release.Name }}-postgres-pvc
{{- end }}


{{/*
Create the name of the configmap to use for postgres
*/}}
{{- define "cluster-wizard.DB.configmap" -}}
{{ .Release.Name }}-postgres-configmap
{{- end }}

{{/* Allow KubeVersion to be overridden. */}}
{{- define "cluster-wizard.ingress.kubeVersion" -}}
  {{- default .Capabilities.KubeVersion.Version .Values.expose.ingress.kubeVersionOverride -}}
{{- end -}}
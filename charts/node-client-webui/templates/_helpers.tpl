{{/*
Expand the name of the chart.
*/}}
{{- define "node-client-webui.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "node-client-webui.fullname" -}}
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
{{- define "node-client-webui.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "node-client-webui.labels" -}}
helm.sh/chart: {{ include "node-client-webui.chart" . }}
{{ include "node-client-webui.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "node-client-webui.selectorLabels" -}}
app.kubernetes.io/name: {{ include "node-client-webui.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the secret to use
*/}}
{{- define "node-client-webui.secretCredential" -}}
{{ .Release.Name }}-secret
{{- end }}

{{/*
Create the name of the configmap to use
*/}}
{{- define "node-client-webui.configmapName" -}}
{{ .Release.Name }}-configmap
{{- end }}

{{/*
Create the name of the service to use
*/}}
{{- define "node-client-webui.service" -}}
{{ .Release.Name }}-service
{{- end }}

{{/*
Create the name of the pvc to use
*/}}
{{- define "node-client-webui.volumeClaim" -}}
{{ .Release.Name }}-pvc
{{- end }}

{{/* Allow KubeVersion to be overridden. */}}
{{- define "node-client-webui.ingress.kubeVersion" -}}
  {{- default .Capabilities.KubeVersion.Version .Values.expose.ingress.kubeVersionOverride -}}
{{- end -}}

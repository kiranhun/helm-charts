{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "helm-backend.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "helm-backend.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" $name .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "helm-backend.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "helm-backend.labels" -}}
helm.sh/chart: {{ include "helm-backend.chart" . }}
{{ include "helm-backend.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "helm-backend.selectorLabels" -}}
app.kubernetes.io/name: {{ include "helm-backend.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "helm-backend.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "helm-backend.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}
{{- define "imagePullSecret" -}}
{{- printf "{\"auths\": {\"%s\": {\"auth\": \"%s\"}}}" .Values.imageCredentials.registry (printf "%s:%s" .Values.imageCredentials.username .Values.imageCredentials.password | b64enc) | b64enc }}
{{- end }}
{{/*
Expand default docker secret name.
*/}}
{{- define "helm-backend.secret-name" -}}
{{- printf "%s-%s" (include "helm-backend.fullname" .) "default-docker-secret" -}}
{{- end -}}
{{/*
Expand service name.
*/}}
{{- define "helm-backend.serviceName" -}}
{{- printf "%s-%s" (include "helm-backend.fullname" .) .Values.service.name }}
{{- end -}}

{{/*
Expand service name.
*/}}
{{- define "helm-backend.databaseConfig" -}}
{{- printf "%s-%s" (include "helm-backend.fullname" .) "api-config" }}
{{- end -}}
{{/*
Expand service name.
*/}}
{{- define "helm-backend.databaseSecret" -}}
{{- printf "%s-%s" (include "helm-backend.fullname" .) "api-secret" }}
{{- end -}}
{{/*
Expand s3 name.
*/}}
{{- define "helm-backend.s3Secret" -}}
{{- printf "%s-%s" (include "helm-backend.fullname" .) "s3-secret" }}
{{- end -}}
{{/*
Expand the name of the chart.
*/}}
{{- define "ssu-commerce.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "gateway-server.name" -}}
{{- .Values.gateway.name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "book-server.name" -}}
{{- .Values.book.name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "order-server.name" -}}
{{- .Values.order.name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "config-server.name" -}}
{{- .Values.config.name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "account-server.name" -}}
{{- .Values.account.name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "front-server.name" -}}
{{- .Values.front.name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "ssu-commerce.fullname" -}}
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
{{- define "ssu-commerce.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "ssu-commerce.labels" -}}
helm.sh/chart: {{ include "ssu-commerce.chart" . }}
{{ include "ssu-commerce.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "ssu-commerce.selectorLabels" -}}
app.kubernetes.io/name: {{ include "ssu-commerce.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "gateway-server.selectorLabels" -}}
app: {{ include "gateway-server.name" . }}
{{- end }}

{{- define "book-server.selectorLabels" -}}
app: {{ include "book-server.name" . }}
{{- end }}

{{- define "order-server.selectorLabels" -}}
app: {{ include "order-server.name" . }}
{{- end }}

{{- define "config-server.selectorLabels" -}}
app: {{ include "config-server.name" . }}
{{- end }}

{{- define "account-server.selectorLabels" -}}
app: {{ include "account-server.name" . }}
{{- end }}

{{- define "front-server.selectorLabels" -}}
app: {{ include "front-server.name" . }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "ssu-commerce.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "ssu-commerce.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Service annotations
*/}}
{{- define "ssu-commerce.annotations" -}}
service.beta.kubernetes.io/ncloud-load-balancer-layer-type: {{ .Values.service.loadBalancer.type }}
service.beta.kubernetes.io/ncloud-load-balancer-internal: "false"
service.beta.kubernetes.io/ncloud-load-balancer-size: {{ .Values.service.loadBalancer.size }}
{{- end }}

{{/*
Expand the name of the chart.
*/}}
{{- define "todo.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "todo.fullname" -}}
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
{{- define "todo.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "todo.labels" -}}
helm.sh/chart: {{ include "todo.chart" . }}
app.kubernetes.io/name: {{ include "todo.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Frontend Selector labels
*/}}
{{- define "todo.frontendSelectorLabels" -}}
tier: {{ printf "%s-frontend" (include "todo.fullname" .) }}
{{- end }}

{{/*
Backend Selector labels
*/}}
{{- define "todo.backendSelectorLabels" -}}
tier: {{ printf "%s-backend" (include "todo.fullname" .) }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "todo.serviceAccountName" -}}
{{- .Values.serviceAccount.name | default (printf "%s-sa" (include "todo.fullname" .))  }}
{{- end }}

{{/*
Create the name of the secret provider class to use
*/}}
{{- define "todo.secretProviderClassName" -}}
{{- .Values.secretProviderClass.name | default (printf "%s-spc" (include "todo.fullname" .))  }}
{{- end }}


{{/*
Create the name of the frontend service to use
*/}}
{{- define "todo.frontendServiceName" -}}
{{- .Values.service.frontend.name | default (printf "%s-frontend-svc" (include "todo.fullname" .))  }}
{{- end }}

{{/*
Create the name of the backend service to use
*/}}
{{- define "todo.backendServiceName" -}}
{{- .Values.service.backend.name | default (printf "%s-backend-svc" (include "todo.fullname" .))  }}
{{- end }}


{{/*
Create the name of the frontend deployment to use
*/}}
{{- define "todo.frontendDeploymentName" -}}
{{- .Values.deployment.frontend.name | default (printf "%s-frontend-deploy" (include "todo.fullname" .))  }}
{{- end }}

{{/*
Create the name of the backend deployment to use
*/}}
{{- define "todo.backendDeploymentName" -}}
{{- .Values.deployment.backend.name | default (printf "%s-backend-deploy" (include "todo.fullname" .))  }}
{{- end }}


{{/*
Create the name of the ingress to use
*/}}
{{- define "todo.ingressName" -}}
{{- .Values.ingress.name | default (printf "%s-ingress" (include "todo.fullname" .))  }}
{{- end }}



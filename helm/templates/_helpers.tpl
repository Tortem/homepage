{{- define "homepage.name" -}}
homepage
{{- end }}

{{- define "homepage.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name (include "homepage.name" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
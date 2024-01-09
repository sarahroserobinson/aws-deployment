{{/* _helpers.tpl */}}

{{- define "my-k8s-app-chart.fullname" -}}
  {{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

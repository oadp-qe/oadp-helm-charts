{{/*
Return the restore.spec.includeClusterResources object
*/}}

{{- define "restore.spec.includeClusterResources" -}}
{{- if .Values.restore.includeClusterResources.enable }}
includeClusterResources: {{ .Values.restore.includeClusterResources.bool }}
{{- end }}
{{- end }}

{{/*
Return the restore.spec.excludedResources list
*/}}

{{- define "restore.spec.excludedResources" -}}
{{- if .Values.restore.excludedResources }}
excludedResources:
{{- range .Values.restore.excludedResources }}
  - {{ . }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Return the restore.spec.existingResourcePolicy object
*/}}

{{- define "restore.spec.existingResourcePolicy" -}}
{{- if .Values.restore.existingResourcePolicy.enable }}
existingResourcePolicy: {{ .Values.restore.existingResourcePolicy.policy }}
{{- end }}
{{- end }}

{{/*
Return the restore.spec.namespaceMapping object
*/}}

{{- define "restore.spec.namespaceMapping" -}}
{{- if .Values.restore.namespaceMapping.enable }}
namespaceMapping:
{{- range .Values.restore.namespaceMapping.maps }}
  {{ printf "%s: %s" .sourceNs .targetNs }}
{{- end }}
{{- end }}
{{- end }}
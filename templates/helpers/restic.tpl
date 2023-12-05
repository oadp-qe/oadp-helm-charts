{{/*
Return the dpa.spec.configuration.restic object for Restic
*/}}

{{- define "oadp.dpa.restic" -}}
{{- if .Values.restic.enable }}
restic:
  enable: true
{{- end }}
{{- end }}
{{/*
Return the dpa.spec.configuration.nodeAgent object for native DataMover
*/}}

{{- define "oadp.dpa.nativeDm" -}}
{{- if .Values.ndm.enable }}
nodeAgent:
  enable: true
  uploaderType: kopia
{{- end }}
{{- end }}
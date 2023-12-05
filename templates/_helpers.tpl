{{/*
Return the dpa.spec.configuration.nodeAgent object for file system backup
*/}}

{{- define "oadp.dpa.fs" -}}
{{- if .Values.fs.enable }}
nodeAgent:
  enable: {{ .Values.fs.bool }}
  {{- include "oadp.dpa.fs.uploaderType" . | indent 2 }}
  {{- if .Values.fs.podConfig.enable }}
  podConfig:
  {{- include "dpa.spec.configuration.nodeAgent.podConfig.tolerations" . | indent 2 }}
  {{- include "dpa.spec.configuration.nodeAgent.podConfig.env" . | indent 2 }}
  {{- end }}
{{- end }}
{{- end }}

{{/*
Return the dpa.spec.configuration.nodeAgent.uploaderType object for file system backup
*/}}

{{- define "oadp.dpa.fs.uploaderType" -}}
{{- if .Values.fs.restic }}
uploaderType: restic
{{- else if .Values.fs.kopia }}
uploaderType: kopia
{{- end }}
{{- end }}

{{/*
Return the dpa.spec.backupImages
*/}}

{{- define "oadp.dpa.backupImages" -}}
{{- if .Values.backupImages.enable }}
backupImages: {{ .Values.backupImages.bool }}
{{- end }}
{{- end }}

{{/*
Return the dpa.spec.configuration.nodeAgent.podConfig.env object
*/}}

{{- define "dpa.spec.configuration.nodeAgent.podConfig.env" -}}
  {{- if .Values.fs.podConfig.env.enable }}
  env:
    {{- range .Values.fs.podConfig.env.envs }}
    - name: {{ .name | quote }}
      value: {{ .val | quote }}
    {{- end }}
  {{- end }}
{{- end }}

{{/*
Return the dpa.spec.configuration.nodeAgent.podConfig.tolerations object
*/}}

{{- define "dpa.spec.configuration.nodeAgent.podConfig.tolerations" -}}
  {{- if .Values.fs.podConfig.toleration.enable }}
  tolerations:
    {{- range .Values.fs.podConfig.toleration.tolerations }}
    - key: {{ .key | quote }}
      operator: {{ .operator | quote }}
      effect: {{ .effect | quote }}
    {{- end }}
  {{- end }}
{{- end }}

{{/*
Return the dpa.spec.unsupportedOverrides object
*/}}

{{- define "dpa.spec.unsupportedOverrides" -}}
{{- if .Values.unsupportedOverrides.enable }}
unsupportedOverrides:
{{- range .Values.unsupportedOverrides.maps }}
  {{ printf "%s: %s" .key .image }}
{{- end }}
{{- end }}
{{- end }}

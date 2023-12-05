{{/*
Return the dpa.spec.features object for DataMover plugin
*/}}

{{- define "oadp.features.dm" -}}
{{- if .Values.dm.enable }}
features:
  dataMover:
    enable: true
    {{- include "oadp.dpa.dm.timeout" . | indent 4 }}
{{- end }}
{{- end }}

{{/*
Return the dpa.spec.configuration.velero.defaultPlugins vsm parameter
*/}}

{{- define "oadp.dpa.defaultPlugins.dm" -}}
{{- if .Values.dm.vsmPlugin }}
  - "vsm"
{{- end }}
{{- end }}

{{/*
Return the dpa.spec.features.dataMover.timeout object for DataMover plugin
*/}}

{{- define "oadp.dpa.dm.timeout" -}}
{{- if .Values.dm.timeout.enable }}
timeout: {{ .Values.dm.timeout.value }}
{{- end }}
{{- end }}

{{/*
Return a manifest to create Secret CR for DataMover plugin
*/}}

{{- define "oadp.restic.secret.dm" -}}
{{- if .Values.dm.enable }}
apiVersion: v1
kind: Secret
metadata:
  name: dm-credential
  namespace: {{ .Values.namespace }}
type: Opaque
stringData:
  RESTIC_PASSWORD: my-secure-restic-password
{{- end }}
{{- end }}
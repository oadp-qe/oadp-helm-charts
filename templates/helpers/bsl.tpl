{{/*
Return the dpa.spec.backupLocations object
*/}}

{{- define "oadp.backupLocations" -}}
{{- $initialContext := . }}
backupLocations:
{{- range .Values.bsl.bsls }}
- name: {{ .credentials.name }}
  velero:
    provider: {{ .provider }}
    default: {{ .default }}
    objectStorage:
      bucket: {{ .bucket }}
      prefix: velero
      {{- if .caCert.enable }}
      caCert: {{ $initialContext.Files.Get "credentials/ca.cert" | b64enc | quote }}
      {{- end }}
    {{- if .credentials.enable }}
    credential:
      name: {{ .credentials.secretName }}
      key: {{ .credentials.secretKey }}
    {{- end }}
      {{- include "oadp.dpa.objectStorage.aws" . | indent 4 }}
      {{- include "oadp.dpa.provider.aws.objectStorage.noobaa" . | indent 4 }}
      {{- include "oadp.dpa.provider.aws.objectStorage.minio" . | indent 4 }}
{{- end }}
{{- end }}

{{/*
Return a manifest to create Secret CR for the BackupStorageLocation CR
*/}}

{{- define "oadp.secret.bsl" -}}
{{- $initialContext := . }}
{{- range .Values.bsl.bsls }}
{{- if .credentials.createSecret.enable }}
apiVersion: v1
kind: Secret
metadata:
  name: {{ .credentials.secretName }}
  namespace: {{ $initialContext.Values.namespace }}
type: Opaque
data:
  {{ .credentials.secretKey }}: {{ $initialContext.Files.Get (printf "credentials/%s" .credentials.createSecret.fileName) | b64enc | quote }}
{{- end }}
{{- end }}
{{- end }}
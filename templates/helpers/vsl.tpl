{{/*
Return the dpa.spec.snapshotLocations object
*/}}

{{- define "oadp.snapshotLocations" -}}
{{- if .Values.vsl.enable }}
{{- $initialContext := . }}
snapshotLocations:
{{- range .Values.vsl.vsls }}
  - velero:
      provider: {{ .provider }}
      {{- include "oadp.snapshotLocations.credential" . | indent 6 }}
      {{- include "oadp.dpa.provider.aws.vsl.config" . | indent 6 }} 
      {{- include "oadp.dpa.provider.gcp.vsl.config" . | indent 6 }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Return the dpa.spec.snapshotLocations[].velero.credential object
*/}}

{{- define "oadp.snapshotLocations.credential" -}}
{{- if .credentials.enable }}
credential:
  name: {{ .credentials.secretName }}
  key: {{ .credentials.secretKey }}
{{- end }}
{{- end }}

{{/*
Return a manifest to create Secret CR for the VolumeSnapshotLocation CR
*/}}

{{- define "oadp.secret.vsl.snapshotLocations.credentials" -}}
{{- $initialContext := . }}
{{- range .Values.vsl.vsls }}
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

{{/*
Return the backup.spec.volumeSnapshotLocations list
*/}}

{{- define "backup.spec.volumeSnapshotLocations" -}}
{{- if .Values.backup.volumeSnapshotLocations }}
volumeSnapshotLocations:
{{- range .Values.backup.volumeSnapshotLocations }}
  - {{ . }}
{{- end }}
{{- end }}
{{- end }}


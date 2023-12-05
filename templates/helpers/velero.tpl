{{/*
Return the dpa.spec.configuration.velero.featureFlags object
*/}}

{{- define "oadp.dpa.featureFlags" -}}
{{- if .Values.velero.featureFlags.enable }}
featureFlags:
{{- range .Values.velero.featureFlags.flags }}
  - "{{ . }}"
{{- end }}
{{- end }}
{{- end }}

{{/*
Return the dpa.spec.configuration.velero.noDefaultBackupLocation object
*/}}

{{- define "oadp.dpa.noDefaultBackupLocation" -}}
{{- if .Values.velero.noDefaultBackupLocation.enable }}
noDefaultBackupLocation: true
{{- end }}
{{- end }}

{{/*
Return the dpa.spec.configuration.velero.defaultPlugins object
*/}}

{{- define "oadp.dpa.defaultPlugins" -}}
{{- if .Values.velero.defaultPlugins }}
{{- range .Values.velero.defaultPlugins }}
  - "{{ . }}"
{{- end }}
{{- end }}
{{- end }}

{{/*
Return the dpa.spec.configuration.velero.defaultPlugins csi parameter
*/}}

{{- define "oadp.dpa.csi" -}}
{{- if .Values.csi.enable }}
  - "csi"
{{- end }}
{{- end }}

{{/*
Return the dpa.spec.configuration.velero.args object
*/}}

{{- define "dpa.spec.configuration.velero.args" -}}
{{- if .Values.velero.args.enable }}
args:
{{- if .Values.velero.args.defaultBackupTtl.enable }}
  default-backup-ttl: {{ .Values.velero.args.defaultBackupTtl.val | int }}
{{- end }}
{{- if .Values.velero.args.garbageCollectionFrequency.enable }}
  garbage-collection-frequency: {{ .Values.velero.args.garbageCollectionFrequency.val | int }}
{{- end }}
{{- end }}
{{- end }}

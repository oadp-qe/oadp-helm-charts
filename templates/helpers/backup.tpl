{{/*
Return the backup.spec.includedNamespaces list
*/}}

{{- define "backup.spec.includedNamespaces" -}}
{{- if .Values.backup.includedNamespaces }}
includedNamespaces:
{{- range .Values.backup.includedNamespaces }}
  - {{ . | quote }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Return the backup.spec.snapshotMoveData: true
*/}}

{{- define "oadp.backup.nativeDm" -}}
{{- if .Values.backup.nativeDm }}
snapshotMoveData: true
{{- end }}
{{- end }}

{{/*
Return the backup.spec.defaultVolumesToFsBackup: true
*/}}

{{- define "oadp.backup.fs" -}}
{{- if .Values.backup.fs }}
defaultVolumesToFsBackup: true
{{- end }}
{{- end }}

{{/*
Return the backup.spec.includedResources list
*/}}

{{- define "backup.spec.includedResources" -}}
{{- if .Values.backup.includedResources }}
includedResources:
{{- range .Values.backup.includedResources }}
  - {{ . }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Return the backup.spec.includedClusterScopedResources list
*/}}

{{- define "backup.spec.includedClusterScopedResources" -}}
{{- if .Values.backup.includedClusterScopedResources }}
includedClusterScopedResources:
{{- range .Values.backup.includedClusterScopedResources }}
  - {{ . }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Return the backup.spec.includeClusterResources object
*/}}

{{- define "backup.spec.includeClusterResources" -}}
{{- if .Values.backup.includeClusterResources.enable }}
includeClusterResources: {{ .Values.backup.includeClusterResources.bool }}
{{- end }}
{{- end }}

{{/*
Return the backup.spec.excludedResources list
*/}}

{{- define "backup.spec.excludedResources" -}}
{{- if .Values.backup.excludedResources }}
excludedResources:
{{- range .Values.backup.excludedResources }}
  - {{ . }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Return the backup.spec.includedNamespaceScopedResources list
*/}}

{{- define "backup.spec.includedNamespaceScopedResources" -}}
{{- if .Values.backup.includedNamespaceScopedResources }}
includedNamespaceScopedResources:
{{- range .Values.backup.includedNamespaceScopedResources }}
  - {{ . }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Return the backup.spec.resourcePolicy object
*/}}

{{- define "backup.spec.resourcePolicy" -}}
{{- if .Values.backup.resourcePolicy.enable }}
resourcePolicy:
  kind: {{ .Values.backup.resourcePolicy.kind }}
  name: {{ .Values.backup.resourcePolicy.name }}
{{- end }}
{{- end }}

{{/*
Return the backup.spec.excludedClusterScopedResources list
*/}}

{{- define "backup.spec.excludedClusterScopedResources" -}}
{{- if .Values.backup.excludedClusterScopedResources }}
excludedClusterScopedResources:
{{- range .Values.backup.excludedClusterScopedResources }}
  - {{ . }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Return the backup.spec.excludedNamespaceScopedResources list
*/}}

{{- define "backup.spec.excludedNamespaceScopedResources" -}}
{{- if .Values.backup.excludedNamespaceScopedResources }}
excludedNamespaceScopedResources:
{{- range .Values.backup.excludedNamespaceScopedResources }}
  - {{ . }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Return the backup.spec.ttl object
*/}}

{{- define "backup.spec.ttl" -}}
{{- if .Values.backup.ttl.enable }}
ttl: {{ .Values.backup.ttl.val | quote }}
{{- end }}
{{- end }}

{{/*
Return the backup.spec.storageLocation object
*/}}

{{- define "backup.spec.storageLocation" -}}
{{- if .Values.backup.storageLocation.enable }}
storageLocation: {{ .Values.backup.storageLocation.name | quote }}
{{- end }}
{{- end }}

{{/*
Return the backup.spec.csiSnapshotTimeout object
*/}}

{{- define "backup.spec.csiSnapshotTimeout" -}}
{{- if .Values.backup.csiSnapshotTimeout.enable }}
csiSnapshotTimeout: {{ .Values.backup.csiSnapshotTimeout.timeout | quote }}
{{- end }}
{{- end }}

{{/*
Return the backup.spec.labelSelector list
*/}}

{{- define "backup.spec.labelSelector" -}}
{{- if .Values.backup.labelSelector.enable }}
labelSelector:
  {{- if .Values.backup.labelSelector.matchLabels.enable }}
  matchLabels:
  {{- range .Values.backup.labelSelector.matchLabels.labels }}
    {{ printf "%s: %s" .key .val }}
  {{- end }}
  {{- end }}
{{- end }}
{{- end }}

{{/*
Return the backup.spec.snapshotVolumes object
*/}}

{{- define "backup.spec.snapshotVolumes" -}}
{{- if .Values.backup.snapshotVolumes.enable }}
snapshotVolumes: {{ .Values.backup.snapshotVolumes.bool }}
{{- end }}
{{- end }}
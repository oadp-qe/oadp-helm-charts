{{/*
Return the general key value pair of region for AWS cloud
*/}}

{{- define "oadp.dpa.provider.aws.region" -}}
{{- if eq .provider "aws" }}
region: us-east-2
{{- end }}
{{- end }}

{{/*
Return the dpa.spec.snapshotLocations.velero.config object for AWS cloud
*/}}

{{- define "oadp.dpa.provider.aws.vsl.config" -}}
{{- if eq .provider "aws" }}
config:
  {{- include "oadp.dpa.provider.aws.region" . | indent 2 }} 
  profile: default
{{- end }}
{{- end }}

{{/*
Return the dpa.spec.backupLocations.velero.config object of MCG bucket
*/}}

{{- define "oadp.dpa.provider.aws.objectStorage.noobaa" -}}
{{- if and ( eq .provider "aws") (.s3.enable) (.s3.noobaa) }}
config:
  profile: {{ .credentials.createSecret.profile }}
  {{- include "oadp.dpa.provider.aws.region" . | indent 2 }} 
  {{- include "oadp.dpa.bucket.s3" . | indent 2 }}
{{- end }}
{{- end }}

{{/*
Return the dpa.spec.backupLocations.velero.config object of minio bucket
*/}}

{{- define "oadp.dpa.provider.aws.objectStorage.minio" -}}
{{- if and ( eq .provider "aws") (.s3.enable) (.s3.minio) }}
config:
  profile: {{ .credentials.createSecret.profile }}
  {{- include "oadp.dpa.provider.aws.region" . | indent 2 }} 
  {{- include "oadp.dpa.bucket.s3" . | indent 2 }}
{{- end }}
{{- end }}

{{/*
Return the dpa.spec.backupLocations.velero.config object of aws bucket
*/}}

{{- define "oadp.dpa.objectStorage.aws" -}}
{{- if and ( eq .provider "aws") }}
config:
  profile: {{ .credentials.createSecret.profile }}
  {{- include "oadp.dpa.provider.aws.region" . | indent 2 }} 
  {{- if and (.s3.enable) (.s3.aws) }}
  {{- include "oadp.dpa.bucket.s3" . | indent 2 }}
  {{- end }}
{{- end }}
{{- end }}

{{/*
Return a manifest to create VolumeSnapshotClass CR for AWS cloud
*/}}

{{- define "oadp.aws.VolumeSnapshotClass" -}}
{{- if and ( .Values.vsc.enable) (eq .Values.vsc.provider "aws") }}
apiVersion: snapshot.storage.k8s.io/v1
kind: VolumeSnapshotClass
metadata:
  name: {{ .Values.vsc.name }}
  labels:
    velero.io/csi-volumesnapshot-class: "true"
  annotations:
    snapshot.storage.kubernetes.io/is-default-class: "true"
    helm.sh/resource-policy: keep
driver: ebs.csi.aws.com
deletionPolicy: {{ .Values.vsc.deletionPolicy }}
{{- end }}
{{- end }}
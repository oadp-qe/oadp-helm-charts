{{/*
Return a manifest to create VolumeSnapshotClass CR for GCP cloud
*/}}

{{- define "oadp.gcp.VolumeSnapshotClass" -}}
{{- if and ( .Values.vsc.enable) (eq .Values.vsc.provider "gcp") }}
apiVersion: snapshot.storage.k8s.io/v1
kind: VolumeSnapshotClass
metadata:
  name: {{ .Values.vsc.name }}
  labels:
    velero.io/csi-volumesnapshot-class: "true"
  annotations:
    snapshot.storage.kubernetes.io/is-default-class: "true"
    helm.sh/resource-policy: keep
driver: pd.csi.storage.gke.io
deletionPolicy: {{ .Values.vsc.deletionPolicy }}
{{- end }}
{{- end }}

{{/*
Return the dpa.spec.snapshotLocations.velero.config object for GCP cloud
*/}}

{{- define "oadp.dpa.provider.gcp.vsl.config" -}}
{{- if eq .provider "gcp" }}
config:
  project: openshift-qe
  snapshotLocation: us-central1
{{- end }}
{{- end }}

{{/*
Return the dpa.spec.backupLocations.velero.config object for s3 bucket
*/}}

{{- define "oadp.dpa.bucket.s3" -}}
{{- if .s3.enable }}
s3Url: {{ (printf "%s://%s" .s3.protocol .s3.url) | quote }} 
insecureSkipTLSVerify: "true"
s3ForcePathStyle: "true"
{{- end }}
{{- end }}
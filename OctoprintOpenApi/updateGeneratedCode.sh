openapi-generator generate \
-i OctoprintOpenApi.yaml \
-g swift5 \
-t Templates/swift5 \
-o generated \
--api-name-suffix Api \
--additional-properties=responseAs=Combine
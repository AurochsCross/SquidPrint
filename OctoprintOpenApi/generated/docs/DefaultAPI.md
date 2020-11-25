# DefaultAPI

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**printerPrintheadPost**](DefaultAPI.md#printerprintheadpost) | **POST** /printer/printhead | Issue command to printhead


# **printerPrintheadPost**
```swift
    open class func printerPrintheadPost(printHeadInstructions: PrintHeadInstructions, completion: @escaping (_ data: Void?, _ error: Error?) -> Void)
```

Issue command to printhead

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let printHeadInstructions = PrintHeadInstructions(command: PrintHeadCommand(), x: 123, y: 123, z: 123, axes: ["axes_example"]) // PrintHeadInstructions | 

// Issue command to printhead
DefaultAPI.printerPrintheadPost(printHeadInstructions: printHeadInstructions) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **printHeadInstructions** | [**PrintHeadInstructions**](PrintHeadInstructions.md) |  | 

### Return type

Void (empty response body)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


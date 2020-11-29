# DefaultAPI

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**printerBedPost**](DefaultAPI.md#printerbedpost) | **POST** /printer/bed | Issue command to bed
[**printerGet**](DefaultAPI.md#printerget) | **GET** /printer | Current printer state
[**printerPrintheadPost**](DefaultAPI.md#printerprintheadpost) | **POST** /printer/printhead | Issue command to printhead
[**printerToolPost**](DefaultAPI.md#printertoolpost) | **POST** /printer/tool | Issue command to tool


# **printerBedPost**
```swift
    open class func printerBedPost(bedInstructions: BedInstructions, completion: @escaping (_ data: Void?, _ error: Error?) -> Void)
```

Issue command to bed

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let bedInstructions = BedInstructions(command: BedCommand(), target: 123, offset: 123) // BedInstructions | 

// Issue command to bed
DefaultAPI.printerBedPost(bedInstructions: bedInstructions) { (response, error) in
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
 **bedInstructions** | [**BedInstructions**](BedInstructions.md) |  | 

### Return type

Void (empty response body)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **printerGet**
```swift
    open class func printerGet(history: Bool? = nil, limit: Int? = nil, completion: @escaping (_ data: FullState?, _ error: Error?) -> Void)
```

Current printer state

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let history = true // Bool |  (optional)
let limit = 987 // Int |  (optional)

// Current printer state
DefaultAPI.printerGet(history: history, limit: limit) { (response, error) in
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
 **history** | **Bool** |  | [optional] 
 **limit** | **Int** |  | [optional] 

### Return type

[**FullState**](FullState.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

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

# **printerToolPost**
```swift
    open class func printerToolPost(printToolInstructions: PrintToolInstructions, completion: @escaping (_ data: Void?, _ error: Error?) -> Void)
```

Issue command to tool

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let printToolInstructions = PrintToolInstructions(command: PrintToolCommand(), targets: PrintToolValues(tool0: 123, tool1: 123), offsets: PrintToolValues(tool0: 123, tool1: 123)) // PrintToolInstructions | 

// Issue command to tool
DefaultAPI.printerToolPost(printToolInstructions: printToolInstructions) { (response, error) in
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
 **printToolInstructions** | [**PrintToolInstructions**](PrintToolInstructions.md) |  | 

### Return type

Void (empty response body)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


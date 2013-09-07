InterApp
========

InterApp is a small library which provides a simple interface for inter-application communication and a bit more.
The approach is based on services and provides an unified way to call services in-app and inter-app using URL-schemes.
No URL-parsing is needed, the library parses the URL and calls the appropiate selectors on the appropiate target.

## Usage
Register services:
```objective-c
/// In App A
[[IAServiceManager sharedManager] registerService:self forSelector:@"alert://show"];
```

```objective-c
/// In App B
[[IAServiceManager sharedManager] registerService:masterViewController forSelector:@"todo://list"];
```

Call a service (from app A):
```objective-c
/// App B will be started using URL scheme.
[[[IAServiceManager sharedManager] proxyToService:@"todo://list"] addItem:self.textField.text]; 
```

```objective-c
/// Will be handled locally.
[[[IAServiceManager sharedManager] proxyToService:@"alert://show"] presentAlert:self.textField.text]; 
```

## Some details
`proxyToService:serviceSelector` returns a proxy instance which records all selectors called on it (except `invoke`),
and finally on the proxy's dealloc or on explicitly called `invoke` the recorded sequence will be invoked.

The invocation will be handled either - locally if there is any matching service recorded - or by forming an appropiate url and passing the request to any other installed application which registered the used URL scheme and can handle the request.

## Restrictions
- All published service methodes must have only object-type parameters, and return values.
- Inter-app calls can handle only JSON-convertable objects specified for [NSJSONSerialization](https://developer.apple.com/library/ios/documentation/Foundation/Reference/NSJSONSerialization_Class/Reference/Reference.html)

## Note
See the working sample applications and the library code for more details.

## Planned Features
- handling returned values using block-based callbacks.
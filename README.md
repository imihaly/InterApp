InterApp
========

InterApp is a small library which provides a simple interface for inter-application communication and a bit more.
The approach is based on services and provides an unified way to call services in-app and inter-app using URL-schemes.

## Usage
Register a service:
```objective-c
    [[IAServiceManager sharedManager] registerService:self forSelector:@"alert://show"];
```

Call a service:
```objective-c
[[[IAServiceManager sharedManager] proxyToService:@"todo://list"] addItem:self.textField.text];
```

```objective-c
[[[IAServiceManager sharedManager] proxyToService:@"alert://show"] presentAlert:self.textField.text];
```

## Some details
`proxyToService:serviceSelector` returns a proxy instance which records all selectors called on it (except `invoke`),
and finally on the proxy's dealloc or on explicitly called `invoke` the recorded sequence will be invoked.

The invocation will be handled either - locally if there is any matching service recorded - or by forming an appropiate url and passing the request to any other installed application which registered the used URL scheme and can handle the request.

See the working sample applications and the library code for more details.
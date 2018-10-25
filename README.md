# gtoolkit-inspector
GT Inspector is the moldable inspector for Pharo. It is part of the [Glamorous Toolkit project](https://github.com/feenkcom/gtoolkit).

## How to load

The ideal way to load the code is by loading the entire GT code. However, you can load the inspector code in Pharo 7.0 using the following snippet:

```
Metacello new
   baseline: 'GToolkitInspector';
   repository: 'github://feenkcom/gtoolkit-inspector/src';
   load.
```

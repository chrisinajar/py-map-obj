# Map Object
A python implementation of the map-obj function

## Installation
`pip install map_object`

## Usage
```python
from map_object import mapObject

def mapper (key, value, source):
  return [value, ley]

newObject = mapObject({'foo'='bar'}, mapper);
# => {bar: 'foo'}
```

## API

### mapObject(source, mapper)

#### source

Type: `Object`

Source object to copy properties from.

#### mapper

Type: `Function`

Mapping function.

- It has signature `mapper(sourceKey, sourceValue, source)`
- It must return a two item array: `[targetKey, targetValue]`.

# License
MIT

import unittest2
from map_object import mapObject
from functools import partial

testObject = {
  'foo': 'bar',
  'biz': 'booz'
}

class MapObjectTest(unittest2.TestCase):
  def test_basic(self):
    localMapper = partial(mapper, self)
    result = mapObject(testObject, localMapper)
    self.assertEqual(result['foo'], 'baz')
    self.assertEqual(result['biz'], 'baz')
    result = mapObject(testObject, swapValues)
    self.assertEqual(result['bar'], 'foo')
    self.assertEqual(result['booz'], 'biz')
    self.assertIsNone(result.get('foo'))
    self.assertIsNone(result.get('biz'))

def mapper (test, k, v, source):
  test.assertEqual(k in testObject, True, 'has key')
  test.assertEqual(v, testObject[k], 'value is correct')
  return [k, 'baz']
def swapValues (k, v, source):
  return [v, k]

if __name__ == '__main__':
  unittest2.main()

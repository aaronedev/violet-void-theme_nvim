# Violet Void Theme - Python Syntax Test
# This file tests all Python syntax highlighting

# Comments
# Single line comment
"""
Multi-line string (docstring)
"""
'''Another multi-line string'''

# Imports
import os
import sys
from typing import List, Dict, Optional

# Class definition
class TestClass:
    """Test class docstring"""
    
    def __init__(self, value: int = 42):
        self.value = value
        self._private = "private"
        self.__dunder__ = "dunder"
    
    def method(self, arg: str) -> bool:
        """Method docstring"""
        return True

# Function definition
def test_function(arg1: int, arg2: str = "default", *args, **kwargs) -> Optional[List[Dict]]:
    """Function docstring"""
    pass

# Variables and types
integer: int = 42
float_num: float = 3.14
complex_num: complex = 1 + 2j
string: str = "hello"
raw_string: str = r"raw\nstring"
f_string: str = f"value: {integer}"
byte_string: bytes = b"bytes"
boolean: bool = True
none_value: None = None

# Collections
list_var: List[int] = [1, 2, 3]
dict_var: Dict[str, int] = {"key": 42}
set_var = {1, 2, 3}
tuple_var = (1, 2, 3)

# Operators
result = 1 + 2 - 3 * 4 / 5 // 6 % 7
comparison = 1 == 2 and 3 or 4
bitwise = 1 & 2 | 3 ^ 4 ~ 5 << 6 >> 7

# Control flow
if True:
    pass
elif False:
    pass
else:
    pass

for i in range(10):
    break
    continue

while True:
    break

try:
    raise ValueError("error")
except Exception as e:
    pass
finally:
    pass

# Decorators
@decorator
@decorator_with_args(arg="value")
def decorated():
    pass

# Lambda
lambda_func = lambda x: x * 2

# Async
async def async_function():
    await something()
    async with context():
        pass
    async for item in iterator():
        pass

# Match statement (Python 3.10+)
match value:
    case 1:
        pass
    case _:
        pass

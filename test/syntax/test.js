// Violet Void Theme - JavaScript Syntax Test
// This file tests all JavaScript syntax highlighting

// Comments
// Single line comment
/* Multi-line
   comment */
/** JSDoc comment */

// Variables
const constant = "value";
let variable = 42;
var oldStyle = "legacy";

// Types
const string = "double 'quoted'";
const template = `template ${variable}`;
const number = 42;
const float = 3.14;
const hex = 0xFF;
const octal = 0o755;
const binary = 0b1010;
const bigint = 9007199254740991n;
const boolean = true;
const null_val = null;
const undefined_val = undefined;
const symbol = Symbol("desc");

// Collections
const array = [1, 2, 3];
const object = { key: "value", ["computed"]: "key" };
const map = new Map();
const set = new Set();

// Functions
function regular(arg) { return arg; }
const arrow = (arg) => arg;
const async_arrow = async (arg) => await Promise.resolve(arg);
function* generator() { yield 1; }

// Classes
class TestClass extends BaseClass {
    #privateField = "private";
    static staticField = "static";
    
    constructor() {
        super();
    }
    
    method() {
        return this.#privateField;
    }
    
    get getter() { return this.field; }
    set setter(value) { this.field = value; }
}

// Operators
const result = 1 + 2 - 3 * 4 / 5 % 6 ** 7;
const comparison = 1 === 2 && 3 || 4;
const bitwise = 1 & 2 | 3 ^ 4 ~ 5 << 6 >> 7 >>> 8;
const nullish = value ?? "default";
const optional = obj?.property?.method?.();

// Control flow
if (true) {} else if (false) {} else {}
for (let i = 0; i < 10; i++) { break; continue; }
for (const item of iterable) {}
for (const key in object) {}
while (true) { break; }
do {} while (true);
switch (value) {
    case 1: break;
    default: break;
}

try {
    throw new Error("error");
} catch (error) {
} finally {
}

// Async/await
async function asyncFunc() {
    const result = await promise;
    try {
        await asyncOperation();
    } catch (error) {
        console.error(error);
    }
}

// Import/export
import defaultExport from "module";
import { named, as aliased } from "module";
import * as namespace from "module";
export default value;
export { name1, name2 };
export const namedExport = "value";

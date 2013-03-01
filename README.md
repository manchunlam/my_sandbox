# Notes for Asset Pipeline

## _index_ Files

To use _index_ files for external library,

1. Make a directory `library_name` in either `app/assets`, `lib/assets`, or
`vendor/assets` (e.g. `vendor/assets/uploadify`)
2. Make a **subdirectory** of the same name under the above directory (e.g.
`vendor/assets/uploadify/uploadify`)
3. Move all the **contents** of the library to the directory in step 2
4. Make a index file of the appropriate extension in the directory of step 2
(e.g. `vendor/assets/uploadify/uploadify/index.js`)
5. To include all files of the same extension as the _index_ file **and** inside
the directory or subdirectories of `vendor/assets/uploadify`, use

    ```
    //= require_tree .
    ```

6. To include only specific files of the same extension as the _index_

    ```
    //= require uploadify/swfobjects
    ```
Notice the **subdirectory** name is specified. In the eyes of `sprockets`, the
`index.js` file exists in `vendor/assets/uploadify`. So to include specific file
(instead of the whole **subdirectory**), we have to specify the subdirectory
name.
7. For examples, please see `lib/assets/charisma/charisma/index.js` and
`vendor/assets/uploadify/uploadify/index.js`
8. Include the _index_ files in `app/assets/javascripts/application.js`

    ```
    //= require charisma
    //= require uploadify
    ```
9. The same principles apply to `index.css` and `applications.css`

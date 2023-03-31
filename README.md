If you want to convert folders to .json file, for example



`
flutter pub run project_structure_generator:from_folders -root lib/ -output lib/output.json
`

`-root` - root dir


`-output` - output dir for .json file









If you want to convert json to folders, for example

`
flutter pub run project_structure_generator:to_folders -json lib/structure.json -output lib/
`

`-output` - output dir


`-json` - input json dir



See `folder_structure.json` in root path of project for example



```
{
  "name": "project_lib",
  "type": "directory",
  "children": [
    {
      "name": "core",
      "type": "directory",
      "children": [
        {
          "name": "file.txt",
          "type": "file"
        },
        {
          "name": "file2.txt",
          "type": "file"
        }
      ]
    }
  ]
}
```

![Alt Text](./screenshots/img.png)

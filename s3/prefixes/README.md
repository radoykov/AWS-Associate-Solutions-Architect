## Create our bucket

```sh
aws s3 mb s3://prefixes-fun-ar
```

## Create our folder
```sh
aws s3api put-object --bucket prefixes-fun-ar --key="hello/"
```

## Create many folders
```sh
aws s3api put-object --bucket prefixes-fun-ar --key="hello/"
```

## Try to break limit 1024 
```sh
aws s3api put-object --bucket prefixes-fun-ar --key "lorem/ipsum/Lorem/ipsum/dolor/sit/amet/consectetur/adipiscing/elit/Morbi/venenatis/dolor/vitae/enim/vehicula/id/aliquet/urna/varius/Aenean/molestie/ante/sed/dui/blandit/auctor/Aenean/et/blandit/leo/Donec/elementum/ante/non/condimentum/elementum/lorem/sem/lobortis/nisl/sed/imperdiet/enim/eros/eu/purus/Maecenas/et/libero/nisl/Etiam/malesuada/aliquet/tincidunt/Praesent/iaculis/congue/elit/sed/pulvinar/lorem/facilisis/in/Maecenas/lacinia/sapien/ac/est/bibendum/molestie/Phasellus/eu/velit/consectetur/egestas/leo/nec/elementum/nibh/Suspendisse/malesuada/nulla/nec/condimentum/suscipit/mauris/augue/pulvinar/lacus/vitae/imperdiet/dolor/turpis/at/urna/Vestibulum/sit/amet/tincidunt/nunc/In/a/sagittis/quam/Praesent/porta/nisl/id/dignissim/viverra/Etiam/dapibus/lobortis/facilisis/Class/aptent/taciti/sociosqu/ad/litora/torquent/per/conubia/nostra/per/inceptos/himenaeos/Vestibulum/condimentum/ante/eu/malesuada/laoreet/Aliquam/convallis/massa/at/lectus/egestas/sit/amet/porta/velit/tempus/Donec/sit/amet/non/"
```
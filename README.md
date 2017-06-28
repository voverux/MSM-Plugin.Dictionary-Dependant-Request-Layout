# MSM Plugin. Dictionary Dependant Request Layout

This MSM system plugin automatically applies Request form layout depending on a dictionary value.
Please feel free to contact Marval Baltic if you would like to see it working.

## Compatible Versions

| Plugin  | MSM             |
|---------|-----------------|
| 1.0.0   | 14.3.1 - 14.6.0 |

## Installation

Please see your MSM documentation for information on how to install plugins.

## Configuration

Once the plugin has been installed as plugin parameters you need to specify:
* Dictionary Id - Dictionary field according to which value Request layout must by selected
* Plugin Rules - Layout selection Rules saved in json format, e.g. [{"classification_ids":[1,2], "layout_id": 1},{"classification_ids":[3], "layout_id": 1015}]

## Usage

The plugin automatically is loaded in every request form and if required automatically redirects form to apply a new layout.

## Contributing

Any feedback is very welcome.
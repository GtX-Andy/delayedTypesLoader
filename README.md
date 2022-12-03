# DelayedTypesLoader

`Farming Simulator  22`   `Version:  1.0.0.1`

## About

Allows delayed loading of placeable or vehicle types until all mods have finished loading for Farming Simulator 22

## Usage

The following examples show the information required in your modDesc.xml

This is an example using a placeable specialisation, it is the same for vehicles using `<delayedVehicleTypes>` instead.

```xml
    <modDesc>
        <!-- This will make sure that the mod that contains the specialisation is in the mod folder when a user is selecting the mod. -->
        <dependencies>
            <dependency>FS22_CustomMod</dependency>
        </dependencies>

        <!-- This is the path to the DelayedTypesLoader.lua. -->
        <extraSourceFiles>
            <sourceFile filename="scripts/DelayedTypesLoader.lua"/>
        </extraSourceFiles>

        <!-- Method 1: This will inherit the whole placeable type so you can add the extra specialization you require.  -->
        <delayedPlaceableTypes>
            <type name="myPlaceableType" parent="FS22_CustomMod.customPlaceableType" filename="$dataS/scripts/placeables/Placeable.lua">
                <specialization name="windTurbine" />
                <specialization name="incomePerHour" />
            </type>
        </delayedPlaceableTypes>

        <!-- Method 2: This will create a simple placeable if you do not require an existing type and wish only to use the specialization.  -->
        <delayedPlaceableTypes>
            <type name="myPlaceableType" parent="simplePlaceable" filename="$dataS/scripts/placeables/Placeable.lua" >
                <specialization name="FS22_CustomMod.customSpecialization"/>
                <specialization name="windTurbine" />
                <specialization name="incomePerHour" />
            </type>
        </delayedPlaceableTypes>
    </modDesc>
```

## Publishing
The publishing of this script on other sites is not permitted when not included as part of a placeable or vehicle mod for Farming Simulator 22.

## Modification / Converting
Only GtX | Andy is permitted to make modifications to this code including but not limited to bug fixes, enhancements or the addition of new features.

Converting this script or parts of it to other version of the Farming Simulator series is not permitted without written approval from GtX | Andy.

## Versioning
All versioning is controlled by GtX | Andy and not by any other page, individual or company.

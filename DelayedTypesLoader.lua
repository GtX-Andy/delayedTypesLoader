--[[
Author: GtX
Version: 1.0.0.1

Contact:
https://forum.giants-software.com
https://github.com/GtX-Andy

Usage: Allows delayed loading of placeable or vehicle types until all mods have finished loading.
       This is an example using a placeable specialisation, it is the same for vehicles using <delayedVehicleTypes> instead.

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
]]


local modName = g_currentModName
local modDirectory = g_currentModDirectory

local numberDelayedPlaceableTypes = 0
local numberDelayedVehicleTypes = 0
local delayedTypesLoaded = false

-- This is called in async directly after all mods load so saves overwriting a function for this simple feature.
g_xmlManager:addCreateSchemaFunction(function ()
    if not delayedTypesLoaded then
        local xmlFile = XMLFile.load("ModDesc", modDirectory .. "modDesc.xml")

        if xmlFile ~= nil then
            if xmlFile:hasProperty("modDesc.delayedPlaceableTypes.type(0)") then
                xmlFile:iterate("modDesc.delayedPlaceableTypes.type", function (_, typeKey)
                    if g_placeableTypeManager:loadTypeFromXML(xmlFile.handle, typeKey, false, modDirectory, modName) then
                        numberDelayedPlaceableTypes = numberDelayedPlaceableTypes + 1
                    end
                end)
            end

            if numberDelayedPlaceableTypes > 0 then
                -- Logging.devInfo("[%s] %d delayed placeable types added ", modName, numberDelayedPlaceableTypes)
            end

            if xmlFile:hasProperty("modDesc.delayedVehicleTypes.type(0)") then
                xmlFile:iterate("modDesc.delayedVehicleTypes.type", function (_, typeKey)
                    if g_vehicleTypeManager:loadTypeFromXML(xmlFile.handle, typeKey, false, modDirectory, modName) then
                        numberDelayedVehicleTypes = numberDelayedVehicleTypes + 1
                    end
                end)
            end

            if numberDelayedVehicleTypes > 0 then
                -- Logging.devInfo("[%s] %d delayed vehicle types added ", modName, numberDelayedVehicleTypes)
            end

            xmlFile:delete()
        end

        delayedTypesLoaded = true
    end
end)

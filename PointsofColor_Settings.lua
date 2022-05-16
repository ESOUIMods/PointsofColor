local LAM = LibAddonMenu2

local panelData = {
  type = "panel",
  name = "PointsofColor",
  displayName = "PointsofColor",
  author = "Jhenox",
  version = poc.version,
  slashCommand = "/poc",
  registerForRefresh = true,
  registerForDefaults = true,
}

local function build_table(index, title, tooltip, path, table_data)
  local optionsTable = {
    [index] = {
      type = "submenu",
      name = title,
      tooltip = tooltip,
      controls = {},
    },
  }
  for i = 1, #table_data do
    optionsTable[index]["controls"][i] = {
      type = "texture",
      image = path .. table_data[i][1],
      imageWidth = table_data[i][2],
      imageHeight = table_data[i][2],
      tooltip = table_data[i][1],
      width = "half",
    }
  end
  return optionsTable[index]
end

function poc:initLAM(poi_textures_complete, poi_textures_incomplete, service_textures)
  local optionsTable = {}
  optionsTable[1] = {
    type = "submenu",
    name = "General Options",
    --tooltip = ""
    controls = {
      [1] = {
        type = "checkbox",
        name = "Show POI Glow Background",
        tooltip = "Enable the default glow background on wayshrines and dungeons.",
        default = false,
        getFunc = function() return poc.SV.show_poi_glow_textures end,
        setFunc = function(val) poc.SV.show_poi_glow_textures = val end,
        width = "full",
        warning = "The game will need to be completely reloaded to take effect.",
      },
      [2] = {
        type = "checkbox",
        name = "Less Color Saturation Icons.",
        tooltip = "This will make PointsofColor load textures with less color saturation.",
        default = false,
        getFunc = function() return poc.SV.use_less_saturation_textures end,
        setFunc = function(val) poc.SV.use_less_saturation_textures = val end,
        width = "full",
        warning = "The game will need to be completely reloaded to take effect.",
      },
    },
  }
  optionsTable[2] = build_table(2, "View Points of Interest - Complete", "View the textures for completed/discovered/owned points-of-interest.", "esoui\\art\\icons\\poi\\", poi_textures_complete)
  optionsTable[3] = build_table(3, "View Points of Interest - Incomplete", "View the textures for incomplete/undiscovered/unowned points-of-interest.", "esoui\\art\\icons\\poi\\", poi_textures_incomplete)
  optionsTable[4] = build_table(4, "View Service Locations", "View the textures for service locations.", "esoui\\art\\icons\\servicemappins\\", service_textures)

  LAM:RegisterAddonPanel("PointsofColor", panelData)
  LAM:RegisterOptionControls("PointsofColor", optionsTable)
end
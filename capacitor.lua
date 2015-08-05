-- from http://www.computercraft.info/forums2/index.php?/topic/22157-ender-io-capacitor-bank-monitoring/
local capacitor_1 = peripheral.wrap("right")
local modem = peripheral.wrap("back")
local monitor = peripheral.wrap("monitor_1")
monitor.setTextColor(1) --text will be white
monitor.setBackgroundColor(128) --background will be gray
monitor.clear() --paint the background
i = 1
--percentage math constants
makePercent = 100
capacitorCount = 5
capacitorBasic = 1000000
capacitorStandard = 5000000
capacitorVibrant = 25000000
totalCapacity = (capacitorCount) * (capacitorStandard)
fillPercentage = 0
difference = 0
while true do
  energyLevel1 = capacitor_1.getEnergyStored()
  energyAdjusted = (energyLevel1) * (capacitorCount)
  --print(energyAdjusted)
  fillLevel = (4500000) * (capacitorCount)
  lowFillLevel = (3000000) * (capacitorCount)
  if energyAdjusted > fillLevel then
        redstone.setOutput("bottom", true)
        monitor.setCursorPos(6, 5)
        monitor.setTextColor(16384) --text will be red
        monitor.write("Generators Inactive")
  end
  if redstone.getOutput("bottom") == true then
        monitor.setCursorPos(6, 5)
        monitor.setTextColor(16384) --text will be red
        monitor.write("Generators Inactive")
  end
  if redstone.getOutput("bottom") == false then
        monitor.setCursorPos(7,5)
        monitor.setTextColor(8192) --text will be green
        monitor.write("Generators Active")
  end
  if energyAdjusted < lowFillLevel then
        redstone.setOutput("bottom", false)
        monitor.setCursorPos(7,5)
        monitor.setTextColor(8192) --text will be green
        monitor.write("Generators Active")
  end
  monitor.setCursorPos(1,1)
  print("Generators with start at "..lowFillLevel.." RF")
  print("Current energy storage is "..energyAdjusted.." RF")
  --monitor.write("Current energy storage is "..energyAdjusted.." RF")
  difference = (totalCapacity) - (energyAdjusted)
  fillAmount = (energyAdjusted) / (totalCapacity)
  fillPercentage = (fillAmount) * (100)
  fillInt = math.floor(fillPercentage)
  monitor.setCursorPos(3,2)
  monitor.setTextColor(1)
  monitor.write("Currently at "..fillInt.."% capacity")
  --monitor.write(string.format("%.2fillPercentage", fillPercentage))
  sleep(2.5)
  monitor.clear()
end

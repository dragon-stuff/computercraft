-- from http://www.computercraft.info/forums2/index.php?/topic/22157-ender-io-capacitor-bank-monitoring/
local capacitor_1 = peripheral.wrap("right")
local monitor = peripheral.wrap("top")
monitor.clear() --paint the background
--percentage math constants
makePercent = 100
fill = 1
stop_fill = 40e6
start_fill = 10e6
totalCapacity = 50e6
while true do
  energyLevel1 = capacitor_1.getEnergyStored()
  energyAdjusted = (energyLevel1) * (capacitorCount)
  print(energyAdjusted)
  monitor.setCursorPos(6, 5)
  if energyAdjusted > stop_fill then
    fill = 0
    monitor.write("Generator: off")
  elseif energyAdjusted < start_fill then
    fill = 1
    monitor.write("Generator: on")
  end
  
  if fill == 1 then
    redstone.setOutput("bottom", true)
  else
    redstone.setOutput("bottom", false)
  end
  
  monitor.setCursorPos(1,1)
  print("Current energy storage is "..energyAdjusted.." RF")
  fillAmount = (energyAdjusted) / (totalCapacity)
  fillPercentage = (fillAmount) * (100)
  fillInt = math.floor(fillPercentage)
  monitor.setCursorPos(3,2)
  monitor.write("Currently at "..fillInt.."% capacity")
  sleep(2.5)
  monitor.clear()
end

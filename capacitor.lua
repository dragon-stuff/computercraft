-- from http://www.computercraft.info/forums2/index.php?/topic/22157-ender-io-capacitor-bank-monitoring/
local capacitor_1 = peripheral.wrap("right")
local monitor = peripheral.wrap("top")
monitor.clear() --paint the background
--percentage math constants
makePercent = 100
fill = 1
totalCapacity = 80e6
stop_fill = totalCapacity*0.9
start_fill = totalCapacity*0.2

while true do
  energyLevel1 = capacitor_1.getEnergyStored()
  energyAdjusted = (energyLevel1) * (capacitorCount)
  if energyAdjusted > stop_fill then
    fill = 0
    print "Overfill"
  elseif energyAdjusted < start_fill then
    fill = 1
    print "Underfill"
  end
  
  monitor.setCursorPos(1,3)
  if fill == 1 then
    redstone.setOutput("bottom", true)
    monitor.write("On")
  else
    redstone.setOutput("bottom", false)
    monitor.write("Off")
  end
  
  monitor.setCursorPos(1,1)
  monitor.write(string.format("%.7f", energyAdjusted/1e6).."M RF")
  fillAmount = (energyAdjusted) / (totalCapacity)
  fillPercentage = (fillAmount) * (100)
  fillInt = math.floor(fillPercentage)
  monitor.setCursorPos(1,2)
  monitor.write(fillInt.."% full")
  sleep(2.5)
  monitor.clear()
end

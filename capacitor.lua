-- from http://www.computercraft.info/forums2/index.php?/topic/22157-ender-io-capacitor-bank-monitoring/
local capacitor_1 = peripheral.wrap("right")
local monitor = peripheral.wrap("top")
monitor.clear() --paint the background
--percentage math constants
makePercent = 100
last = 0
fill = 1
totalCapacity = 80e6
stop_fill = totalCapacity*0.9
start_fill = totalCapacity*0.2
sleep_time = 5 -- seconds between cpu updates

while true do
  energyLevel1 = capacitor_1.getEnergyStored()
  diff = energyLevel1 - last
  energyAdjusted = (energyLevel1) * (capacitorCount)
  if energyAdjusted > stop_fill then
    fill = 0
    print "Overfill"
  elseif energyAdjusted < start_fill then
    fill = 1
    print "Underfill"
  end
  
  fillAmount = (energyAdjusted) / (totalCapacity)
  fillPercentage = (fillAmount) * (100)
  fillInt = math.floor(fillPercentage)
  monitor.setCursorPos(1,1)
  monitor.write(math.floor(energyAdjusted/1e6).."M RF")
  
  monitor.setCursorPos(1,2)
  monitor.write(fillInt.."%")
  
  monitor.setCursorPos(1,3)
  if fill == 1 then
    redstone.setOutput("bottom", true)
    monitor.write("On")
  else
    redstone.setOutput("bottom", false)
    monitor.write("Off")
  end
  
  monitor.setCursorPos(1,4)
  monitor.write(math.floor(diff/sleep_time/1000)..'k RF/s')
  
  sleep(sleep_time)
  monitor.clear()
end

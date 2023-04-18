turbine = peripheral.wrap("turbineValve_0")
reactor = peripheral.wrap("fissionReactorLogicAdapter_0")
 
while true do
    if turbine.getEnergyFilledPercentage() >= 0.8 and reactor.getStatus() then
        reactor.scram()
    end
    if turbine.getEnergyFilledPercentage() <= 0.7 and not reactor.getStatus() then
        reactor.activate()
    end
end
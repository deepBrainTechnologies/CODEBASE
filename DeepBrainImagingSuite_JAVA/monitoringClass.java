/*
*    ---------- public class monitoringClass ------------
*    DeepBrainTechnologies fundamentals and foundations:
*        --configuration rules and determines architecture
*        --1 class must have 1 constructor driven by config received.
*        --we must return void almost always! (no try -> catches!)
*/
public class monitoringClass{
	//properties ------------------------------
	int nDev;
	configClass config;    //stores configuration of entire suite
	devicesClass devices;  //handles devices (usbs, tcp, IoT, files, etc)
	
	//public methods ---------------------------------
	public void monitoringClass(classConfig config){
		this.config = config;  
		this.addListOfDevices();
	}
	
	//startMonitoring
	public void start(){
		this.startMonitoringDevices();
	}
	
	//endMonitoring
	public void end(){
	}
	
	//private methods ---------------------------------
	private void addListOfDevices(){
		this.nDev = this.config.devices.nDevices;
		for (int devIX=1; devIX<this.nDev; devIX++){
			this.devices.addDevice(devIX, this.config.confDevs.identifiers[devIX], this.config.confDevs);
		} 
	}
	
	private void startMonitoringDevices(){
		for (int devIX=1; devIX<this.nDev; devIX++){
			this.devices.startDevice(devIX);
		} 
	}
	
}
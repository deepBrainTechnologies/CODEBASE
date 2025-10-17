/*
*    ---------- public class monitoringClass ------------
*    DeepBrainTechnologies fundamentals and foundations:
*        --configuration rules and determines architecture
*        --1 class must have 1 constructor driven by config received.
*        --we must return void almost always! (no try -> catches!)
*        --avoid set/get of parameters. security is enforced by granting access to code!
*
*/
public class devicesClass{
	//properties -------------------------------------------
	public int nDev; 
	int[] devicesList;  //universal device identifier
	
	//methods ----------------------------------------------
	public void addDevice(int devIX, int identifier, configDevClass devices){
		this.devicesList[devIX] = identifier;
		
	}
	
}
*    ---------- public class configClass  (structure)------------
*    DeepBrainTechnologies fundamentals and foundations:
*        --configuration rules and determines architecture
*        --1 class must have 1 constructor driven by config received.
*        --we must return void almost always! (no try -> catches!)
*/
public class configClass{
	public int nDevices
	public configDevClass confDevs;   //configuration of devices to monitor (files, usbs, IoT, tcp, etc)
	public configWinsClass confWindows;  //configuration of windows to display
	
}
/*
*    ---------- public class configDevClass (structure) ------------
*    DeepBrainTechnologies fundamentals and foundations:
*        --configuration rules and determines architecture
*        --1 class must have 1 constructor driven by config received.
*        --we must return void almost always! (never use try -> catches!)
*/
public class configDevClass{
	//properties ----------------------------------
	public int nDev;
	public int[] identifiers; //identifier of each device example: 0002 0005 0045 0046 (range indicates type)
	
	//methods -------------------------------------
	public configDevClass(int nDev){
		this.nDev = nDev;
		this.identifiers = new int[nDev];
	}
}
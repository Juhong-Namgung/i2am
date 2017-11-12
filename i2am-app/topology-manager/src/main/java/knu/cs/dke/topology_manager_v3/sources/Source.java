package knu.cs.dke.topology_manager_v3.sources;

public abstract class Source {
	
	// Source Info.
	private String sourceID;	
	private String owner;
	private String timeStamp;
	
	private String hostIp;
	private String hostPort;		
	
	// System Kafka Info.
	private String systemTopic;
	
	public void setSourceID(String sourceID) {
		this.sourceID = sourceID;
	}
	public String getSourceID() {
		return this.sourceID;
	}
	
	public void setOwner(String owner) {
		this.owner = owner;
	}
	public String getOwner() {
		return owner;
	}
	
	public void setTimeStamp(String timeStamp) {
		this.timeStamp = timeStamp;
	}
	public String getTimeStamp() {
		return this.timeStamp;
	}
	
	public void setHostIp(String hostIp) {
		this.hostIp = hostIp;
	}
	public void setHostPort(String port) {
		this.hostPort = port;
	}
	
	public void setTopic(String topic) {
		this.systemTopic = topic;
	}
	public String getTopic(String topic) {
		return this.systemTopic;
	}
	
	public abstract void read(); // 읽어서 우리 시스템의 Kafka로 !!
}

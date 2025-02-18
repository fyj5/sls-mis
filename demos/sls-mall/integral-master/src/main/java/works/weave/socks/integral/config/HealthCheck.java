package works.weave.socks.integral.config;


import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import java.util.Calendar;
import java.util.Date;

@JsonIgnoreProperties(ignoreUnknown = true)
public class HealthCheck {
    private String service;
    private String status;

    @JsonFormat(pattern="yyyy-MM-dd'T'HH:mm:ss.SSSXXX")
    private Date date = Calendar.getInstance().getTime();

    public HealthCheck() {

    }

    public HealthCheck(String service, String status, Date date) {
        this.service = service;
        this.status = status;
        this.date = date;
    }

    @Override
    public String toString() {
        return "HealthCheck{" +
                "service='" + service + '\'' +
                ", status='" + status + '\'' +
                ", date='" + date +
                '}';
    }

    public String getService() {
        return service;
    }

    public void setService(String service) {
        this.service = service;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }
}


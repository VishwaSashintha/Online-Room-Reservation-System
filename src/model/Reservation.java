package model;
import java.sql.Date;
public class Reservation {
    private int reservationId;
    private String guestName;
    private String address;
    private String contact;
    private String roomType;
    private Date checkIn;
    private Date checkOut;
    private double totalBill;
    public Reservation() {
    }
    public Reservation(int reservationId, String guestName, String address, String contact, 
                      String roomType, Date checkIn, Date checkOut, double totalBill) {
        this.reservationId = reservationId;
        this.guestName = guestName;
        this.address = address;
        this.contact = contact;
        this.roomType = roomType;
        this.checkIn = checkIn;
        this.checkOut = checkOut;
        this.totalBill = totalBill;
    }
    public int getReservationId() {
        return reservationId;
    }
    public void setReservationId(int reservationId) {
        this.reservationId = reservationId;
    }
    public String getGuestName() {
        return guestName;
    }
    public void setGuestName(String guestName) {
        this.guestName = guestName;
    }
    public String getAddress() {
        return address;
    }
    public void setAddress(String address) {
        this.address = address;
    }
    public String getContact() {
        return contact;
    }
    public void setContact(String contact) {
        this.contact = contact;
    }
    public String getRoomType() {
        return roomType;
    }
    public void setRoomType(String roomType) {
        this.roomType = roomType;
    }
    public Date getCheckIn() {
        return checkIn;
    }
    public void setCheckIn(Date checkIn) {
        this.checkIn = checkIn;
    }
    public Date getCheckOut() {
        return checkOut;
    }
    public void setCheckOut(Date checkOut) {
        this.checkOut = checkOut;
    }
    public double getTotalBill() {
        return totalBill;
    }
    public void setTotalBill(double totalBill) {
        this.totalBill = totalBill;
    }
    @Override
    public String toString() {
        return "Reservation{" +
                "reservationId=" + reservationId +
                ", guestName='" + guestName + '\'' +
                ", roomType='" + roomType + '\'' +
                ", checkIn=" + checkIn +
                ", checkOut=" + checkOut +
                ", totalBill=" + totalBill +
                '}';
    }
}

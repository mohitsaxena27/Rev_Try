package apiModal;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import groovyjarjarpicocli.CommandLine;

import java.util.List;

public class Order {
    private Data data;

    public Data getData() {
        return data;
    }

    public void setData(Data data) {
        this.data = data;
    }

    public static class Data {


        private String stateTaxCode="";
        private AdditionalServices additionalServices;
        private String storeNumber="081";
        private String notes="";
        private String orderNumber="600501";
        private int totalOrderItems=2;
        private String documentNumber="721001_1712746210031.BOTS";
        private List<Payment> payments;
        private String orderStatus="Pick";
        private double deliveryCharge=0;
        private double subTotal=602.93;
        private boolean forceTaxableFlag=false;
        private String webCustomerId="885013";
        private double total;
        private String customerType;
        private String fulfillmentSource;
        private boolean manualFulfillment;
        private List<PaymentInformation> paymentInformation;
        private String orderSource;
        private int salesmanNumber;
        private boolean specialOrderFlag;
        private String salesTerritory;
        private boolean shipCompleteFlag;
        private double shippingCostToTP;
        private int webOrderNumber;
        private String customerNumber;
        private String serviceName;
        private String selectedPrinter;
        private String site;
        private List<Promotion> promotions;
        private String shipCarrier;
        private String purchaseOrderNumber;
        private double estimatedTax;
        private String paymentMethodUsed;
        private double estimatedShipping;
        private ShippingAddress shippingAddress;
        private List<OrderLineItem> orderLineItems;
        private BillingAddress billingAddress;
        private String orderDate;
        private double fuelSurcharge;

        public String getStateTaxCode() {
            return stateTaxCode;
        }

        public void setStateTaxCode(String stateTaxCode) {
            this.stateTaxCode = stateTaxCode;
        }

        public AdditionalServices getAdditionalServices() {
            return additionalServices;
        }

        public void setAdditionalServices(AdditionalServices additionalServices) {
            this.additionalServices = additionalServices;
        }

        public String getStoreNumber() {
            return storeNumber;
        }

        public void setStoreNumber(String storeNumber) {
            this.storeNumber = storeNumber;
        }

        public String getNotes() {
            return notes;
        }

        public void setNotes(String notes) {
            this.notes = notes;
        }

        public String getOrderNumber() {
            return orderNumber;
        }

        public void setOrderNumber(String orderNumber) {
            this.orderNumber = orderNumber;
        }

        public int getTotalOrderItems() {
            return totalOrderItems;
        }

        public void setTotalOrderItems(int totalOrderItems) {
            this.totalOrderItems = totalOrderItems;
        }

        public String getDocumentNumber() {
            return documentNumber;
        }

        public void setDocumentNumber(String documentNumber) {
            this.documentNumber = documentNumber;
        }

        public List<Payment> getPayments() {
            return payments;
        }

        public void setPayments(List<Payment> payments) {
            this.payments = payments;
        }

        public String getOrderStatus() {
            return orderStatus;
        }

        public void setOrderStatus(String orderStatus) {
            this.orderStatus = orderStatus;
        }

        public double getDeliveryCharge() {
            return deliveryCharge;
        }

        public void setDeliveryCharge(double deliveryCharge) {
            this.deliveryCharge = deliveryCharge;
        }

        public double getSubTotal() {
            return subTotal;
        }

        public void setSubTotal(double subTotal) {
            this.subTotal = subTotal;
        }

        public boolean isForceTaxableFlag() {
            return forceTaxableFlag;
        }

        public void setForceTaxableFlag(boolean forceTaxableFlag) {
            this.forceTaxableFlag = forceTaxableFlag;
        }

        public String getWebCustomerId() {
            return webCustomerId;
        }

        public void setWebCustomerId(String webCustomerId) {
            this.webCustomerId = webCustomerId;
        }

        public double getTotal() {
            return total;
        }

        public void setTotal(double total) {
            this.total = total;
        }

        public String getCustomerType() {
            return customerType;
        }

        public void setCustomerType(String customerType) {
            this.customerType = customerType;
        }

        public String getFulfillmentSource() {
            return fulfillmentSource;
        }

        public void setFulfillmentSource(String fulfillmentSource) {
            this.fulfillmentSource = fulfillmentSource;
        }

        public boolean isManualFulfillment() {
            return manualFulfillment;
        }

        public void setManualFulfillment(boolean manualFulfillment) {
            this.manualFulfillment = manualFulfillment;
        }

        public List<PaymentInformation> getPaymentInformation() {
            return paymentInformation;
        }

        public void setPaymentInformation(List<PaymentInformation> paymentInformation) {
            this.paymentInformation = paymentInformation;
        }

        public String getOrderSource() {
            return orderSource;
        }

        public void setOrderSource(String orderSource) {
            this.orderSource = orderSource;
        }

        public int getSalesmanNumber() {
            return salesmanNumber;
        }

        public void setSalesmanNumber(int salesmanNumber) {
            this.salesmanNumber = salesmanNumber;
        }

        public boolean isSpecialOrderFlag() {
            return specialOrderFlag;
        }

        public void setSpecialOrderFlag(boolean specialOrderFlag) {
            this.specialOrderFlag = specialOrderFlag;
        }

        public String getSalesTerritory() {
            return salesTerritory;
        }

        public void setSalesTerritory(String salesTerritory) {
            this.salesTerritory = salesTerritory;
        }

        public boolean isShipCompleteFlag() {
            return shipCompleteFlag;
        }

        public void setShipCompleteFlag(boolean shipCompleteFlag) {
            this.shipCompleteFlag = shipCompleteFlag;
        }

        public double getShippingCostToTP() {
            return shippingCostToTP;
        }

        public void setShippingCostToTP(double shippingCostToTP) {
            this.shippingCostToTP = shippingCostToTP;
        }

        public int getWebOrderNumber() {
            return webOrderNumber;
        }

        public void setWebOrderNumber(int webOrderNumber) {
            this.webOrderNumber = webOrderNumber;
        }

        public String getCustomerNumber() {
            return customerNumber;
        }

        public void setCustomerNumber(String customerNumber) {
            this.customerNumber = customerNumber;
        }

        public String getServiceName() {
            return serviceName;
        }

        public void setServiceName(String serviceName) {
            this.serviceName = serviceName;
        }

        public String getSelectedPrinter() {
            return selectedPrinter;
        }

        public void setSelectedPrinter(String selectedPrinter) {
            this.selectedPrinter = selectedPrinter;
        }

        public String getSite() {
            return site;
        }

        public void setSite(String site) {
            this.site = site;
        }

        public List<Promotion> getPromotions() {
            return promotions;
        }

        public void setPromotions(List<Promotion> promotions) {
            this.promotions = promotions;
        }

        public String getShipCarrier() {
            return shipCarrier;
        }

        public void setShipCarrier(String shipCarrier) {
            this.shipCarrier = shipCarrier;
        }

        public String getPurchaseOrderNumber() {
            return purchaseOrderNumber;
        }

        public void setPurchaseOrderNumber(String purchaseOrderNumber) {
            this.purchaseOrderNumber = purchaseOrderNumber;
        }

        public double getEstimatedTax() {
            return estimatedTax;
        }

        public void setEstimatedTax(double estimatedTax) {
            this.estimatedTax = estimatedTax;
        }

        public String getPaymentMethodUsed() {
            return paymentMethodUsed;
        }

        public void setPaymentMethodUsed(String paymentMethodUsed) {
            this.paymentMethodUsed = paymentMethodUsed;
        }

        public double getEstimatedShipping() {
            return estimatedShipping;
        }

        public void setEstimatedShipping(double estimatedShipping) {
            this.estimatedShipping = estimatedShipping;
        }

        public ShippingAddress getShippingAddress() {
            return shippingAddress;
        }

        public void setShippingAddress(ShippingAddress shippingAddress) {
            this.shippingAddress = shippingAddress;
        }

        public List<OrderLineItem> getOrderLineItems() {
            return orderLineItems;
        }

        public void setOrderLineItems(List<OrderLineItem> orderLineItems) {
            this.orderLineItems = orderLineItems;
        }

        public BillingAddress getBillingAddress() {
            return billingAddress;
        }

        public void setBillingAddress(BillingAddress billingAddress) {
            this.billingAddress = billingAddress;
        }

        public String getOrderDate() {
            return orderDate;
        }

        public void setOrderDate(String orderDate) {
            this.orderDate = orderDate;
        }

        public double getFuelSurcharge() {
            return fuelSurcharge;
        }

        public void setFuelSurcharge(double fuelSurcharge) {
            this.fuelSurcharge = fuelSurcharge;
        }

        // Getters and setters for all fields
    }

    public static class AdditionalServices {

        private boolean residentialFlag;

        public boolean isResidentialFlag() {
            return residentialFlag;
        }

        public void setResidentialFlag(boolean residentialFlag) {
            this.residentialFlag = residentialFlag;
        }


        // Getter and setter for residentialFlag
    }

    public static class Payment {

        private double paymentAmount;
        private String paymentType;

        public double getPaymentAmount() {
            return paymentAmount;
        }

        public void setPaymentAmount(double paymentAmount) {
            this.paymentAmount = paymentAmount;
        }

        public String getPaymentType() {
            return paymentType;
        }

        public void setPaymentType(String paymentType) {
            this.paymentType = paymentType;
        }




    }

    public static class PaymentInformation {

        private String paymentTxRefNum;
        private String paymentOrderID;
        private String paymentStatus;

        public String getPaymentTxRefNum() {
            return paymentTxRefNum;
        }

        public void setPaymentTxRefNum(String paymentTxRefNum) {
            this.paymentTxRefNum = paymentTxRefNum;
        }

        public String getPaymentOrderID() {
            return paymentOrderID;
        }

        public void setPaymentOrderID(String paymentOrderID) {
            this.paymentOrderID = paymentOrderID;
        }

        public String getPaymentStatus() {
            return paymentStatus;
        }

        public void setPaymentStatus(String paymentStatus) {
            this.paymentStatus = paymentStatus;
        }



        // Getters and setters for paymentTxRefNum, paymentOrderID, and paymentStatus
    }

    public static class Promotion {
        private int promoApplied;
        private String promoType;
        private String promoCode;

        public int getPromoApplied() {
            return promoApplied;
        }

        public void setPromoApplied(int promoApplied) {
            this.promoApplied = promoApplied;
        }

        public String getPromoType() {
            return promoType;
        }

        public void setPromoType(String promoType) {
            this.promoType = promoType;
        }

        public String getPromoCode() {
            return promoCode;
        }

        public void setPromoCode(String promoCode) {
            this.promoCode = promoCode;
        }



        // Getters and setters for promoApplied, promoType, and promoCode
    }

    public static class ShippingAddress {
        private String zipCode;
        private String country;
        private String city;
        private String addressLine1;
        private String geoCode;
        private String attentionTo;
        private String addressLine2;
        private String addressLine3;
        private String state;

        public String getZipCode() {
            return zipCode;
        }

        public void setZipCode(String zipCode) {
            this.zipCode = zipCode;
        }

        public String getCountry() {
            return country;
        }

        public void setCountry(String country) {
            this.country = country;
        }

        public String getCity() {
            return city;
        }

        public void setCity(String city) {
            this.city = city;
        }

        public String getAddressLine1() {
            return addressLine1;
        }

        public void setAddressLine1(String addressLine1) {
            this.addressLine1 = addressLine1;
        }

        public String getGeoCode() {
            return geoCode;
        }

        public void setGeoCode(String geoCode) {
            this.geoCode = geoCode;
        }

        public String getAttentionTo() {
            return attentionTo;
        }

        public void setAttentionTo(String attentionTo) {
            this.attentionTo = attentionTo;
        }

        public String getAddressLine2() {
            return addressLine2;
        }

        public void setAddressLine2(String addressLine2) {
            this.addressLine2 = addressLine2;
        }

        public String getAddressLine3() {
            return addressLine3;
        }

        public void setAddressLine3(String addressLine3) {
            this.addressLine3 = addressLine3;
        }

        public String getState() {
            return state;
        }

        public void setState(String state) {
            this.state = state;
        }
// Getters and setters for all fields
    }

  //  @JsonSerialize(include = JsonSerialize.Inclusion.NON_DEFAULT)
    public static class OrderLineItem {

      private double unitPrice;
        private String serialNumber;
        private String tpnmfcCode;
        private PriceOverride priceOverride;
        private String tpltlClass;
        private String description;
        private int quantityOrdered;
        private String tpnmfcDesc;
        private String type;
        private int orderDetailId;
        private String productName;
        private double regPrice;
        private double discApplied;
        private int coreExchangeQuantity;
        private int quantityShipped;
        private String tphazmatCode;
        private double coreCostToTP;
        private String partNumber;
        private List<Fulfillment> fulfillment;
        private double corePrice;
      private String notesPrintScope;
      private String notes;
      public String getNotes() {
          return notes;
      }

      public void setNotes(String notes) {
          this.notes = notes;
      }


      public String getNotesPrintScope() {
          return notesPrintScope;
      }

      public void setNotesPrintScope(String notesPrintScope) {
          this.notesPrintScope = notesPrintScope;
      }



        public double getUnitPrice() {
            return unitPrice;
        }

        public void setUnitPrice(double unitPrice) {
            this.unitPrice = unitPrice;
        }

        public String getSerialNumber() {
            return serialNumber;
        }

        public void setSerialNumber(String serialNumber) {
            this.serialNumber = serialNumber;
        }

        public String getTpnmfcCode() {
            return tpnmfcCode;
        }

        public void setTpnmfcCode(String tpnmfcCode) {
            this.tpnmfcCode = tpnmfcCode;
        }

        public PriceOverride getPriceOverride() {
            return priceOverride;
        }

        public void setPriceOverride(PriceOverride priceOverride) {
            this.priceOverride = priceOverride;
        }

        public String getTpltlClass() {
            return tpltlClass;
        }

        public void setTpltlClass(String tpltlClass) {
            this.tpltlClass = tpltlClass;
        }

        public String getDescription() {
            return description;
        }

        public void setDescription(String description) {
            this.description = description;
        }

        public int getQuantityOrdered() {
            return quantityOrdered;
        }

        public void setQuantityOrdered(int quantityOrdered) {
            this.quantityOrdered = quantityOrdered;
        }

        public String getTpnmfcDesc() {
            return tpnmfcDesc;
        }

        public void setTpnmfcDesc(String tpnmfcDesc) {
            this.tpnmfcDesc = tpnmfcDesc;
        }

        public String getType() {
            return type;
        }

        public void setType(String type) {
            this.type = type;
        }

        public int getOrderDetailId() {
            return orderDetailId;
        }

        public void setOrderDetailId(int orderDetailId) {
            this.orderDetailId = orderDetailId;
        }

        public String getProductName() {
            return productName;
        }

        public void setProductName(String productName) {
            this.productName = productName;
        }

        public double getRegPrice() {
            return regPrice;
        }

        public void setRegPrice(double regPrice) {
            this.regPrice = regPrice;
        }

        public double getDiscApplied() {
            return discApplied;
        }

        public void setDiscApplied(double discApplied) {
            this.discApplied = discApplied;
        }

        public int getCoreExchangeQuantity() {
            return coreExchangeQuantity;
        }

        public void setCoreExchangeQuantity(int coreExchangeQuantity) {
            this.coreExchangeQuantity = coreExchangeQuantity;
        }

        public int getQuantityShipped() {
            return quantityShipped;
        }

        public void setQuantityShipped(int quantityShipped) {
            this.quantityShipped = quantityShipped;
        }

        public String getTphazmatCode() {
            return tphazmatCode;
        }

        public void setTphazmatCode(String tphazmatCode) {
            this.tphazmatCode = tphazmatCode;
        }

        public double getCoreCostToTP() {
            return coreCostToTP;
        }

        public void setCoreCostToTP(double coreCostToTP) {
            this.coreCostToTP = coreCostToTP;
        }

        public String getPartNumber() {
            return partNumber;
        }

        public void setPartNumber(String partNumber) {
            this.partNumber = partNumber;
        }

        public List<Fulfillment> getFulfillment() {
            return fulfillment;
        }

        public void setFulfillment(List<Fulfillment> fulfillment) {
            this.fulfillment = fulfillment;
        }

        public double getCorePrice() {
            return corePrice;
        }

        public void setCorePrice(double corePrice) {
            this.corePrice = corePrice;
        }
// Getters and setters for all fields
    }

    public static class PriceOverride {
        private boolean priceOverrideExceptionFlag;
        private String priceOverrideSalesmanNumber;
        private boolean priceOverrideFlag;
        private String priceOverrideStoreNumber;

        public boolean isPriceOverrideExceptionFlag() {
            return priceOverrideExceptionFlag;
        }

        public void setPriceOverrideExceptionFlag(boolean priceOverrideExceptionFlag) {
            this.priceOverrideExceptionFlag = priceOverrideExceptionFlag;
        }

        public String getPriceOverrideSalesmanNumber() {
            return priceOverrideSalesmanNumber;
        }

        public void setPriceOverrideSalesmanNumber(String priceOverrideSalesmanNumber) {
            this.priceOverrideSalesmanNumber = priceOverrideSalesmanNumber;
        }

        public boolean isPriceOverrideFlag() {
            return priceOverrideFlag;
        }

        public void setPriceOverrideFlag(boolean priceOverrideFlag) {
            this.priceOverrideFlag = priceOverrideFlag;
        }

        public String getPriceOverrideStoreNumber() {
            return priceOverrideStoreNumber;
        }

        public void setPriceOverrideStoreNumber(String priceOverrideStoreNumber) {
            this.priceOverrideStoreNumber = priceOverrideStoreNumber;
        }
// Getters and setters for all fields
    }

    public static class Fulfillment {
        private String fulfillmentStore;
        private String shipMode;
        private int quantityFulfilled;
        private String fulfillmentType;

        public String getFulfillmentStore() {
            return fulfillmentStore;
        }

        public void setFulfillmentStore(String fulfillmentStore) {
            this.fulfillmentStore = fulfillmentStore;
        }

        public String getShipMode() {
            return shipMode;
        }

        public void setShipMode(String shipMode) {
            this.shipMode = shipMode;
        }

        public int getQuantityFulfilled() {
            return quantityFulfilled;
        }

        public void setQuantityFulfilled(int quantityFulfilled) {
            this.quantityFulfilled = quantityFulfilled;
        }

        public String getFulfillmentType() {
            return fulfillmentType;
        }

        public void setFulfillmentType(String fulfillmentType) {
            this.fulfillmentType = fulfillmentType;
        }
// Getters and setters for all fields
    }

    public static class BillingAddress {
        private String zipCode;
        private String country;
        private String city;
        private String customerFirstName;
        private String addressLine1;
        private String geoCode;
        private String customerLastName;
        private String addressLine2;
        private String addressLine3;
        private String state;
        private String email;

        public String getZipCode() {
            return zipCode;
        }

        public void setZipCode1(String zipCode) {
            this.zipCode = zipCode;
        }

        public String getCountry() {
            return country;
        }

        public void setCountry(String country) {
            this.country = country;
        }

        public String getCity() {
            return city;
        }

        public void setCity(String City) {
            this.city = City;
        }

        public String getCustomerFirstName() {
            return customerFirstName;
        }

        public void setCustomerFirstName(String customerFirstName) {
            this.customerFirstName = customerFirstName;
        }

        public String getAddressLine1() {
            return addressLine1;
        }

        public void setAddressLine11(String addressLine1) {
            this.addressLine1 = addressLine1;
        }

        public String getGeoCode() {
            return geoCode;
        }

        public void setGeoCode1(String geoCode) {
            this.geoCode = geoCode;
        }

        public String getCustomerLastName() {
            return customerLastName;
        }

        public void setCustomerLastName(String customerLastName) {
            this.customerLastName = customerLastName;
        }

        public String getAddressLine2() {
            return addressLine2;
        }

        public void setAddressLine21(String addressLine2) {
            this.addressLine2 = addressLine2;
        }

        public String getAddressLine3() {
            return addressLine3;
        }

        public void setAddressLine31(String addressLine3) {
            this.addressLine3 = addressLine3;
        }

        public String getState() {
            return state;
        }

        public void setState1(String state) {
            this.state = state;
        }

        public String getEmail() {
            return email;
        }

        public void setEmail(String email) {
            this.email = email;
        }
// Getters and setters for all fields
    }


}
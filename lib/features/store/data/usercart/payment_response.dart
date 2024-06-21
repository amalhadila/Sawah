class PaymentResponse {
    String status;
    Session session;

    PaymentResponse({
        required this.status,
        required this.session,
    });

    factory PaymentResponse.fromJson(Map<String, dynamic> json) => PaymentResponse(
        status: json["status"],
        session: Session.fromJson(json["session"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "session": session.toJson(),
    };
}

class Session {
    String id;
    String object;
    dynamic afterExpiration;
    dynamic allowPromotionCodes;
    int amountSubtotal;
    int amountTotal;
    AutomaticTax automaticTax;
    dynamic billingAddressCollection;
    String cancelUrl;
    String clientReferenceId;
    dynamic clientSecret;
    dynamic consent;
    dynamic consentCollection;
    int created;
    String currency;
    dynamic currencyConversion;
    List<dynamic> customFields;
    CustomText customText;
    dynamic customer;
    String customerCreation;
    CustomerDetails customerDetails;
    String customerEmail;
    int expiresAt;
    dynamic invoice;
    InvoiceCreation invoiceCreation;
    bool livemode;
    dynamic locale;
    Metadata metadata;
    String mode;
    dynamic paymentIntent;
    dynamic paymentLink;
    String paymentMethodCollection;
    dynamic paymentMethodConfigurationDetails;
    PaymentMethodOptions paymentMethodOptions;
    List<String> paymentMethodTypes;
    String paymentStatus;
    PhoneNumberCollection phoneNumberCollection;
    dynamic recoveredFrom;
    dynamic savedPaymentMethodOptions;
    dynamic setupIntent;
    dynamic shippingAddressCollection;
    dynamic shippingCost;
    dynamic shippingDetails;
    List<dynamic> shippingOptions;
    String status;
    dynamic submitType;
    dynamic subscription;
    String successUrl;
    TotalDetails totalDetails;
    String uiMode;
    String url;

    Session({
        required this.id,
        required this.object,
        required this.afterExpiration,
        required this.allowPromotionCodes,
        required this.amountSubtotal,
        required this.amountTotal,
        required this.automaticTax,
        required this.billingAddressCollection,
        required this.cancelUrl,
        required this.clientReferenceId,
        required this.clientSecret,
        required this.consent,
        required this.consentCollection,
        required this.created,
        required this.currency,
        required this.currencyConversion,
        required this.customFields,
        required this.customText,
        required this.customer,
        required this.customerCreation,
        required this.customerDetails,
        required this.customerEmail,
        required this.expiresAt,
        required this.invoice,
        required this.invoiceCreation,
        required this.livemode,
        required this.locale,
        required this.metadata,
        required this.mode,
        required this.paymentIntent,
        required this.paymentLink,
        required this.paymentMethodCollection,
        required this.paymentMethodConfigurationDetails,
        required this.paymentMethodOptions,
        required this.paymentMethodTypes,
        required this.paymentStatus,
        required this.phoneNumberCollection,
        required this.recoveredFrom,
        required this.savedPaymentMethodOptions,
        required this.setupIntent,
        required this.shippingAddressCollection,
        required this.shippingCost,
        required this.shippingDetails,
        required this.shippingOptions,
        required this.status,
        required this.submitType,
        required this.subscription,
        required this.successUrl,
        required this.totalDetails,
        required this.uiMode,
        required this.url,
    });

    factory Session.fromJson(Map<String, dynamic> json) => Session(
        id: json["id"],
        object: json["object"],
        afterExpiration: json["after_expiration"],
        allowPromotionCodes: json["allow_promotion_codes"],
        amountSubtotal: json["amount_subtotal"],
        amountTotal: json["amount_total"],
        automaticTax: AutomaticTax.fromJson(json["automatic_tax"]),
        billingAddressCollection: json["billing_address_collection"],
        cancelUrl: json["cancel_url"],
        clientReferenceId: json["client_reference_id"],
        clientSecret: json["client_secret"],
        consent: json["consent"],
        consentCollection: json["consent_collection"],
        created: json["created"],
        currency: json["currency"],
        currencyConversion: json["currency_conversion"],
        customFields: List<dynamic>.from(json["custom_fields"].map((x) => x)),
        customText: CustomText.fromJson(json["custom_text"]),
        customer: json["customer"],
        customerCreation: json["customer_creation"],
        customerDetails: CustomerDetails.fromJson(json["customer_details"]),
        customerEmail: json["customer_email"],
        expiresAt: json["expires_at"],
        invoice: json["invoice"],
        invoiceCreation: InvoiceCreation.fromJson(json["invoice_creation"]),
        livemode: json["livemode"],
        locale: json["locale"],
        metadata: Metadata.fromJson(json["metadata"]),
        mode: json["mode"],
        paymentIntent: json["payment_intent"],
        paymentLink: json["payment_link"],
        paymentMethodCollection: json["payment_method_collection"],
        paymentMethodConfigurationDetails: json["payment_method_configuration_details"],
        paymentMethodOptions: PaymentMethodOptions.fromJson(json["payment_method_options"]),
        paymentMethodTypes: List<String>.from(json["payment_method_types"].map((x) => x)),
        paymentStatus: json["payment_status"],
        phoneNumberCollection: PhoneNumberCollection.fromJson(json["phone_number_collection"]),
        recoveredFrom: json["recovered_from"],
        savedPaymentMethodOptions: json["saved_payment_method_options"],
        setupIntent: json["setup_intent"],
        shippingAddressCollection: json["shipping_address_collection"],
        shippingCost: json["shipping_cost"],
        shippingDetails: json["shipping_details"],
        shippingOptions: List<dynamic>.from(json["shipping_options"].map((x) => x)),
        status: json["status"],
        submitType: json["submit_type"],
        subscription: json["subscription"],
        successUrl: json["success_url"],
        totalDetails: TotalDetails.fromJson(json["total_details"]),
        uiMode: json["ui_mode"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "object": object,
        "after_expiration": afterExpiration,
        "allow_promotion_codes": allowPromotionCodes,
        "amount_subtotal": amountSubtotal,
        "amount_total": amountTotal,
        "automatic_tax": automaticTax.toJson(),
        "billing_address_collection": billingAddressCollection,
        "cancel_url": cancelUrl,
        "client_reference_id": clientReferenceId,
        "client_secret": clientSecret,
        "consent": consent,
        "consent_collection": consentCollection,
        "created": created,
        "currency": currency,
        "currency_conversion": currencyConversion,
        "custom_fields": List<dynamic>.from(customFields.map((x) => x)),
        "custom_text": customText.toJson(),
        "customer": customer,
        "customer_creation": customerCreation,
        "customer_details": customerDetails.toJson(),
        "customer_email": customerEmail,
        "expires_at": expiresAt,
        "invoice": invoice,
        "invoice_creation": invoiceCreation.toJson(),
        "livemode": livemode,
        "locale": locale,
        "metadata": metadata.toJson(),
        "mode": mode,
        "payment_intent": paymentIntent,
        "payment_link": paymentLink,
        "payment_method_collection": paymentMethodCollection,
        "payment_method_configuration_details": paymentMethodConfigurationDetails,
        "payment_method_options": paymentMethodOptions.toJson(),
        "payment_method_types": List<dynamic>.from(paymentMethodTypes.map((x) => x)),
        "payment_status": paymentStatus,
        "phone_number_collection": phoneNumberCollection.toJson(),
        "recovered_from": recoveredFrom,
        "saved_payment_method_options": savedPaymentMethodOptions,
        "setup_intent": setupIntent,
        "shipping_address_collection": shippingAddressCollection,
        "shipping_cost": shippingCost,
        "shipping_details": shippingDetails,
        "shipping_options": List<dynamic>.from(shippingOptions.map((x) => x)),
        "status": status,
        "submit_type": submitType,
        "subscription": subscription,
        "success_url": successUrl,
        "total_details": totalDetails.toJson(),
        "ui_mode": uiMode,
        "url": url,
    };
}

class AutomaticTax {
    bool enabled;
    dynamic liability;
    dynamic status;

    AutomaticTax({
        required this.enabled,
        required this.liability,
        required this.status,
    });

    factory AutomaticTax.fromJson(Map<String, dynamic> json) => AutomaticTax(
        enabled: json["enabled"],
        liability: json["liability"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "enabled": enabled,
        "liability": liability,
        "status": status,
    };
}

class CustomText {
    dynamic afterSubmit;
    dynamic shippingAddress;
    dynamic submit;
    dynamic termsOfServiceAcceptance;

    CustomText({
        required this.afterSubmit,
        required this.shippingAddress,
        required this.submit,
        required this.termsOfServiceAcceptance,
    });

    factory CustomText.fromJson(Map<String, dynamic> json) => CustomText(
        afterSubmit: json["after_submit"],
        shippingAddress: json["shipping_address"],
        submit: json["submit"],
        termsOfServiceAcceptance: json["terms_of_service_acceptance"],
    );

    Map<String, dynamic> toJson() => {
        "after_submit": afterSubmit,
        "shipping_address": shippingAddress,
        "submit": submit,
        "terms_of_service_acceptance": termsOfServiceAcceptance,
    };
}

class CustomerDetails {
    dynamic address;
    String email;
    dynamic name;
    dynamic phone;
    String taxExempt;
    dynamic taxIds;

    CustomerDetails({
        required this.address,
        required this.email,
        required this.name,
        required this.phone,
        required this.taxExempt,
        required this.taxIds,
    });

    factory CustomerDetails.fromJson(Map<String, dynamic> json) => CustomerDetails(
        address: json["address"],
        email: json["email"],
        name: json["name"],
        phone: json["phone"],
        taxExempt: json["tax_exempt"],
        taxIds: json["tax_ids"],
    );

    Map<String, dynamic> toJson() => {
        "address": address,
        "email": email,
        "name": name,
        "phone": phone,
        "tax_exempt": taxExempt,
        "tax_ids": taxIds,
    };
}

class InvoiceCreation {
    bool enabled;
    InvoiceData invoiceData;

    InvoiceCreation({
        required this.enabled,
        required this.invoiceData,
    });

    factory InvoiceCreation.fromJson(Map<String, dynamic> json) => InvoiceCreation(
        enabled: json["enabled"],
        invoiceData: InvoiceData.fromJson(json["invoice_data"]),
    );

    Map<String, dynamic> toJson() => {
        "enabled": enabled,
        "invoice_data": invoiceData.toJson(),
    };
}

class InvoiceData {
    dynamic accountTaxIds;
    dynamic customFields;
    dynamic description;
    dynamic footer;
    dynamic issuer;
    Metadata metadata;
    dynamic renderingOptions;

    InvoiceData({
        required this.accountTaxIds,
        required this.customFields,
        required this.description,
        required this.footer,
        required this.issuer,
        required this.metadata,
        required this.renderingOptions,
    });

    factory InvoiceData.fromJson(Map<String, dynamic> json) => InvoiceData(
        accountTaxIds: json["account_tax_ids"],
        customFields: json["custom_fields"],
        description: json["description"],
        footer: json["footer"],
        issuer: json["issuer"],
        metadata: Metadata.fromJson(json["metadata"]),
        renderingOptions: json["rendering_options"],
    );

    Map<String, dynamic> toJson() => {
        "account_tax_ids": accountTaxIds,
        "custom_fields": customFields,
        "description": description,
        "footer": footer,
        "issuer": issuer,
        "metadata": metadata.toJson(),
        "rendering_options": renderingOptions,
    };
}

class Metadata {
    Metadata();

    factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
    );

    Map<String, dynamic> toJson() => {
    };
}

class PaymentMethodOptions {
    Card card;

    PaymentMethodOptions({
        required this.card,
    });

    factory PaymentMethodOptions.fromJson(Map<String, dynamic> json) => PaymentMethodOptions(
        card: Card.fromJson(json["card"]),
    );

    Map<String, dynamic> toJson() => {
        "card": card.toJson(),
    };
}

class Card {
    String requestThreeDSecure;

    Card({
        required this.requestThreeDSecure,
    });

    factory Card.fromJson(Map<String, dynamic> json) => Card(
        requestThreeDSecure: json["request_three_d_secure"],
    );

    Map<String, dynamic> toJson() => {
        "request_three_d_secure": requestThreeDSecure,
    };
}

class PhoneNumberCollection {
    bool enabled;

    PhoneNumberCollection({
        required this.enabled,
    });

    factory PhoneNumberCollection.fromJson(Map<String, dynamic> json) => PhoneNumberCollection(
        enabled: json["enabled"],
    );

    Map<String, dynamic> toJson() => {
        "enabled": enabled,
    };
}

class TotalDetails {
    int amountDiscount;
    int amountShipping;
    int amountTax;

    TotalDetails({
        required this.amountDiscount,
        required this.amountShipping,
        required this.amountTax,
    });

    factory TotalDetails.fromJson(Map<String, dynamic> json) => TotalDetails(
        amountDiscount: json["amount_discount"],
        amountShipping: json["amount_shipping"],
        amountTax: json["amount_tax"],
    );

    Map<String, dynamic> toJson() => {
        "amount_discount": amountDiscount,
        "amount_shipping": amountShipping,
        "amount_tax": amountTax,
    };
}

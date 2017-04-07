var TranscriptApplications = TranscriptApplications || {};

TranscriptApplications.updateSets = function() {
    var numberOfSets = $('transcript_application_quantity').val();
}

TranscriptApplications_updateShippingAdvice = function() {

    var element = $(this).id;

    var country = $(element).val();

    if (country == 105) {

    }

    alert(country);

}



TranscriptApplications_bind = function() {

    alert("Bind method");
    $(".country-select").each(function(index, element) {
            alert(element.id);
            $(element).bind('change', TranscriptApplications_updateShippingAdvice);
        });
}

$('#shipping_addressses').on('cocoon:after-insert', function(e, insertedItem) {
    // ... do something

    TranscriptApplications_bind();
});

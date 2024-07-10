
    // Function to open the High Severity Tasks popup
    function openHighSeverityTasksPopup() {
        var modal = document.getElementById("highSeverityTasksModal");
        modal.style.display = "block";
    }

    // Function to close the High Severity Tasks popup
    function closeSeverityTasksPopup(severity) {
        var modal = document.getElementById(severity + "SeverityTasksModal");
        modal.style.display = "none";
    }

    // Function to open the Medium Severity Tasks popup
    function openMediumSeverityTasksPopup() {
        var modal = document.getElementById("mediumSeverityTasksModal");
        modal.style.display = "block";
    }

    // Function to close the Medium Severity Tasks popup
    function closeMediumSeverityTasksPopup() {
        var modal = document.getElementById("mediumSeverityTasksModal");
        modal.style.display = "none";
    }

    // Function to open the Low Severity Tasks popup
    function openLowSeverityTasksPopup() {
        var modal = document.getElementById("lowSeverityTasksModal");
        modal.style.display = "block";
    }

    // Function to close the Low Severity Tasks popup
    function closeLowSeverityTasksPopup() {
        var modal = document.getElementById("lowSeverityTasksModal");
        modal.style.display = "none";
    }

    // Function to open the Completed Tasks popup
    function openCompletedTasksPopup() {
        var modal = document.getElementById("completedTasksModal");
        modal.style.display = "block";
    }

    // Function to close the Completed Tasks popup
    function closeCompletedTasksPopup() {
        var modal = document.getElementById("completedTasksModal");
        modal.style.display = "none";
    }

    // Close the popup if the user clicks outside of it
    window.onclick = function(event) {
        var modal = document.getElementById("completedTasksModal");
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }

	var modal = document.getElementById("ticketModal");
	  var span = document.getElementsByClassName("close")[0];
	  var transferToGroup = document.getElementById("transferToGroup");

	  function openModal(ticketId) {
	      document.getElementById("ticketId").value = ticketId;
	      modal.style.display = "block";
	  }

	  span.onclick = function() {
	      modal.style.display = "none";
	  }

	  window.onclick = function(event) {
	      if (event.target == modal) {
	          modal.style.display = "none";
	      }
	  }

	  function handleActionChange() {
	      var action = document.getElementById("action").value;
	      if (action === "transfer") {
	          transferToGroup.style.display = "block";
	      } else {
	          transferToGroup.style.display = "none";
	      }
	  }
	      $(document).ready(function() {
	          // Function to apply filters
	          function applyFilters() {
	              var severityFilterValue = $('#severityFilter').val().toLowerCase();
	              var assignedByFilterValue = $('#assignedByFilter').val().toLowerCase();

	              // Loop through table rows
	              $('.table tbody tr').each(function() {
	                  var row = $(this);
	                  var severity = row.find('td:eq(2)').text().toLowerCase();
	                  var assignedBy = row.find('td:eq(3)').text().toLowerCase();

	                  // Check if row matches filters
	                  var severityMatch = severityFilterValue === '' || severity.includes(severityFilterValue);
	                  var assignedByMatch = assignedByFilterValue === '' || assignedBy.includes(assignedByFilterValue);

	                  // Toggle row visibility based on filter matches
	                  if (severityMatch && assignedByMatch) {
	                      row.show();
	                  } else {
	                      row.hide();
	                  }
	              });
	          }

	          // Event listeners for filter controls
	          $('#severityFilter').change(applyFilters);
	          $('#assignedByFilter').on('input', applyFilters);
	      });
	 



var voteTotals;

function votestreamTotals(totals) {
  voteTotals = totals;  
  var votes = document.getElementById("votes");
  votes.innerHTML = votes.innerHTML + "<h3>Contestants</h3>";
  // Show totals
  for (i in voteTotals) {
    votes.innerHTML = votes.innerHTML + "<p><strong>" + voteTotals[i].name + "</strong></p>";
  }
  // Write out updates script tag
  var updateIframe = document.createElement("iframe");
  updateIframe.src = "http://localhost:3333/votes/updates?callback=window.parent.votestreamUpdates&timestamp=" + voteTotals.timestamp;
  document.body.appendChild(updateIframe);
}

function votestreamUpdates(updates) {
  var votes = document.getElementById("votes");
  for (i in updates) {
    votes.innerHTML = votes.innerHTML + "<p>" + updates[i].code + " has " + updates[i].newVotes + " new votes";
  }
}

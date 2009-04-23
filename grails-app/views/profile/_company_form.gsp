<label for="phone">Phone: </label><g:textField name="phone" value="${profile?.phone?.encodeAsHTML()}" /><br/>
<label for="phoneShow">Show phone on profile: </label><g:checkBox class="boxes" name="phoneShow" value="${profile?.phoneShow}" /><br/>
<label for="address">Address: </label><g:textField name="address" value="${profile?.address?.encodeAsHTML()}" /><br/>
<label for="description">Description: </label><textarea name="description" rows="8" cols="40">${profile?.description?.encodeAsHTML()}</textarea><br/>
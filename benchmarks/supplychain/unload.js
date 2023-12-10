'use strict';

const rand = require('./random');
const seeds = require('./seeds.json');
const getParameters = require('./getParameters');

class unload {

    static get() {

    let args;
    let standardDerivation = getParameters.keyPickerType();

    let randomAccessKey = rand.randomIndex(seeds.allSSCC.length, standardDerivation);
    while (seeds.allSSCC[randomAccessKey] === undefined) {
        randomAccessKey = rand.randomIndex(seeds.allSSCC.length, standardDerivation);
    }
    let ssccKey = seeds.allSSCC[randomAccessKey];

	    let invkIdent = rand.getClient()
            console.log("invkIdent", invkIdent);
            let targetOrg = rand.getEndorsers()
            console.log("targetOrg", targetOrg);

	args = {
                contractId: 'supplychain',
                contractVersion: 'v1',
                contractFunction: 'unload',
                contractArguments: [ssccKey],
                targetOrganizations: targetOrg,
                invokerIdentity: invkIdent,
                timeout: 30
            };

            return args;

        }
}

module.exports = unload;


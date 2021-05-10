# cz-smartcontracts

Cryptozombies smart contracts

For EPITA 2020-2021 class

---

## Docker commands

- Run `docker-compose -p cz-test -f docker-compose.tests.yml up` to run all tests
- Run `docker-compose -p cz-migrate -f docker-compose.migrate.yml up` to deploy to Ropsten

Deployment will require you to have a `.env` file with the following content:

```
ropsten_infura_apikey = "YourInfuraApiKey"
ropsten_mnemonic = "your mnemonic provided by metamask"
```

---

## Npm commands

This may require additional global npm installations, but here's an indication of what should make the project work locally:

- `npm install -g truffle && npm install -g ganache-cli`
- `npm install`

If you plan to work on the code, you may also want to install additional plugins on VSCode or your favourite IDE:

- Prettier: https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode
- ESLint: https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint
- Solidity: https://marketplace.visualstudio.com/items?itemName=JuanBlanco.solidity

Note that this last linter may pose some issues.

---

Then to run tests, first run a server in one terminal:

- `ganache-cli`

And run the tests in another terminal:

- `npm run test`

To have a coverage of your tests, run:

- `npm run coverage` (This command is not yet containerized)

To migrate to ropsten, run:

- `npm run migrate`

To run the test or the migration through Docker:

- `npm run docker:test`
- `npm run docker:migrate`

### Troubleshoot

- Update your version of npm
- Update your version of node
- Update your version of ganache-cli
- Update your version of truffle

---

## Truffle commands

Most of npm commands are shorthands for truffle commands. Here are the original Truffle commands:

- Run tests (do not forget to have a server running in another terminal): `truffle test`
- Run tests with coverage report: `truffle run coverage`

To deploy the smart contracts:

- `truffle compile`
- `truffle migrate --network ropsten` (you may also replace `ropsten` by the network of your choice)
